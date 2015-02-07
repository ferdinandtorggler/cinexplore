var gulp = require('gulp');

var es = require('event-stream');
var argv = require('yargs').argv;
var gutil = require('gulp-util');

var copy = require('gulp-copy');
var clean = require('gulp-clean');
var gulpif = require('gulp-if');
var stylus = require('gulp-stylus');
var cssmin = require('gulp-minify-css');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var ngAnnotate = require('gulp-ng-annotate');
var autoprefix = require('gulp-autoprefixer');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
var jade = require('gulp-jade');
var sourcemaps = require('gulp-sourcemaps');
var svgstore = require('gulp-svgstore');
var svgmin = require('gulp-svgmin');
var imagemin = require('gulp-imagemin');
var templateCache = require('gulp-angular-templatecache');

var connect = require('gulp-connect');
var livereload = require('gulp-livereload');
var checkUnusedCss = require('gulp-check-unused-css');
var coffeelint = require('gulp-coffeelint');


var styles = {
    all: 'styles/**/*.styl',
    mobile: 'styles/app/mobile/main.styl',
    vendor: 'styles/vendor/*.css',
    dest: 'public/stylesheets',
    destFile: 'public/stylesheets/style.css'
};

var scripts = {
    all: 'scripts/**/*.coffee',
    mobile: {
      src: 'scripts/app/mobile/**/*.coffee',
      app: 'scripts/app/mobile/app.coffee'
    },
    vendor: 'scripts/vendor/**/*.js',
    dest: 'public/scripts/'
};

var templates = {
    all: ['templates/mobile/**/*.jade', 'index.jade'],
    watch: ['templates/**/*.jade', 'index.jade'],
    dest: 'public/',
    angular: {
      mobile: 'templates/mobile/**/*.jade',
      dest: 'public/templates/'
    }
};

var fonts = {
    all: 'fonts/**/*',
    dest: 'public/'
};

var images = {
    all: 'images/**/*',
    dest: 'public/'
};

var icons = {
    all: 'icons/**/*.svg',
    dest: 'public/icons/'
};

console.log('USING ' + (argv.production ? 'PRODUCTION' : 'DEVELOPMENT') + ' SETTINGS')

gulp.task('clean', function () {
  return gulp.src('public', {read: false}).pipe(clean());
});

gulp.task('icons', function () {
  return gulp.src(icons.all)
      .pipe(svgstore({
          prefix: 'icon-',
          inlineSvg: true,
          transformSvg: function (svg, cb) {
              svg.find('//*[@fill]').forEach(function (child) {
                child.attr('fill').remove();
              });
              svg.find('//*[@style]').forEach(function (child) {
                  child.attr('style').remove()
              });
              cb(null);
          }
      }))
      .pipe(svgmin({
          plugins: [{
                      cleanupIDs: false
                  }]
          }))
      .pipe(gulp.dest(icons.dest))
});

gulp.task('fonts', function () {
    return gulp.src(fonts.all)
        .pipe(copy(fonts.dest));
});

gulp.task('images', function () {
    return gulp.src(images.all)
        .pipe(imagemin())
        .pipe(copy(images.dest));
});

gulp.task('styles', function () {
    var mobile = gulp.src(styles.mobile)
        .pipe(stylus()).on('error', gutil.log);
    var vendor = gulp.src(styles.vendor);
    return es.concat(vendor, mobile).on('error', gutil.log)
        .pipe(concat('mobile.css'))
        .pipe(cssmin())
        .pipe(autoprefix('last 1 version'))
        .pipe(gulp.dest(styles.dest));
});

gulp.task('scripts', function () {

    gulp.src(scripts.vendor)
      .pipe(concat('vendor.js'))
      .pipe(uglify())
      .pipe(gulp.dest(scripts.dest));

    return gulp.src(scripts.mobile.app, { read: false })
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      })).on('error', gutil.log)
      .pipe(gulpif(!argv.production, sourcemaps.init() ))
      .pipe(rename('mobile.js'))
      .pipe(ngAnnotate({
        add: true
      }))
      .pipe(uglify())
      .pipe(gulpif(!argv.production, sourcemaps.write() ))
      .pipe(gulp.dest(scripts.dest));
});

gulp.task('lint-coffeescript', function () {
    return gulp.src(scripts.all)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
});

gulp.task('templates', function () {
    return gulp.src(templates.all)
      .pipe(jade({}))
      .pipe(gulp.dest(templates.dest));
});

gulp.task('angular-templates', function () {
  return gulp.src(templates.angular.mobile)
      .pipe(jade())
      .pipe(templateCache('mobile.js', {standalone: true}))
      .pipe(gulp.dest(templates.angular.dest));
});

gulp.task('check-unused-css', function () {
    return gulp.src(styles.destFile)
      .pipe(checkUnusedCss({
          files: 'public/*.html'
      }));
});

gulp.task('connect', function() {
    connect.server({
        root: 'public/'
    });
});

gulp.task('watch', function () {
    var server = livereload();
    gulp.watch(styles.all, ['styles', 'check-unused-css']);
    gulp.watch(scripts.all, ['scripts', 'lint-coffeescript']);
    gulp.watch(templates.watch, ['angular-templates']);
    gulp.watch(icons.all, ['icons']);
    gulp.watch('public/**').on('change', function (file) {
        server.changed(file.path);
    });
})

gulp.task('build', function () {
    gulp.start('styles', 'scripts', 'angular-templates', 'icons', 'fonts', 'images');
});

gulp.task('default', [  'build',
                        'connect',
                        'check-unused-css',
                        'lint-coffeescript',
                        'watch'
                     ]);

module.exports = gulp;