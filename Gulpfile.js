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
var svgsprite = require('gulp-svg-sprite');
var svgmin = require('gulp-svgmin');
var imagemin = require('gulp-imagemin');
var templateCache = require('gulp-angular-templatecache');
var rsp = require('remove-svg-properties').stream;

var connect = require('gulp-connect');
var livereload = require('gulp-livereload');
var checkUnusedCss = require('gulp-check-unused-css');
var coffeelint = require('gulp-coffeelint');


var styles = {
    all: 'styles/**/*.styl',
    mobile: 'styles/app/mobile/main.styl',
    desktop: 'styles/app/desktop/main.styl',
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
    desktop: {
      src: 'scripts/app/desktop/**/*.coffee',
      app: 'scripts/app/desktop/app.coffee'
    },
    vendor: 'scripts/vendor/**/*.js',
    dest: 'public/scripts/'
};

var templates = {
    watch: 'templates/**/*.jade',
    mobile: 'templates/mobile/**/*.jade',
    desktop: 'templates/desktop/**/*.jade',
    dest: 'public/templates/'
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

var processStyles = function (src, outputName) {
    var mobile = gulp.src(src)
        .pipe(stylus()).on('error', gutil.log);
    var vendor = gulp.src(styles.vendor);
    es.concat(vendor, mobile).on('error', gutil.log)
        .pipe(concat(outputName))
        .pipe(cssmin())
        .pipe(autoprefix('last 1 version'))
        .pipe(gulp.dest(styles.dest))
        .pipe(livereload());
};

var processScripts = function (src, outputName) {
    gulp.src(scripts.vendor)
      .pipe(concat('vendor.js'))
      .pipe(uglify())
      .pipe(gulp.dest(scripts.dest));

    return gulp.src(src, { read: false })
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      })).on('error', gutil.log)
      .pipe(gulpif(!argv.production, sourcemaps.init() ))
      .pipe(rename(outputName))
      .pipe(ngAnnotate({
        add: true
      }))
      .pipe(uglify())
      .pipe(gulpif(!argv.production, sourcemaps.write() ))
      .pipe(gulp.dest(scripts.dest))
      .pipe(livereload());
};

var processTemplates = function (src, outputName) {
  return gulp.src(src)
      .pipe(jade())
      .pipe(templateCache(outputName, {standalone: true}))
      .pipe(gulp.dest(templates.dest))
      .pipe(livereload());
};

gulp.task('clean', function () {
  return gulp.src('public', {read: false}).pipe(clean());
});

gulp.task('icons', function () {
  return gulp.src(icons.all)
      .pipe(rsp.remove({
        properties: [rsp.PROPS_FILL]
      }))
      .pipe(svgsprite({
        mode: {
          symbol: true
        }
      }))
      .pipe(svgmin({
          plugins: [{
                      cleanupIDs: false
                  }]
          }))
      .pipe(gulp.dest(icons.dest))
      .pipe(livereload());
});

gulp.task('fonts', function () {
    return gulp.src(fonts.all)
        .pipe(copy(fonts.dest))
        .pipe(livereload());
});

gulp.task('images', function () {
    return gulp.src(images.all)
        .pipe(imagemin())
        .pipe(copy(images.dest))
        .pipe(livereload());
});

gulp.task('styles', function () {
    processStyles(styles.mobile, 'mobile.css');
    processStyles(styles.desktop, 'desktop.css');
});

gulp.task('scripts', function () {
    processScripts(scripts.mobile.app, 'mobile.js');
    processScripts(scripts.desktop.app, 'desktop.js');
});

gulp.task('lint-coffeescript', function () {
    return gulp.src(scripts.all)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
});

gulp.task('templates', function () {
  processTemplates(templates.mobile, 'mobile.js');
  processTemplates(templates.desktop, 'desktop.js');
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
    var server = livereload({ start: true });
    gulp.watch(styles.all, ['styles', 'check-unused-css']);
    gulp.watch(scripts.all, ['scripts', 'lint-coffeescript']);
    gulp.watch(templates.watch, ['templates']);
    gulp.watch(icons.all, ['icons']);
})

gulp.task('build', ['styles', 'scripts', 'templates', 'icons', 'fonts', 'images']);

gulp.task('default', [  'build',
                        'connect',
                        'check-unused-css',
                        'lint-coffeescript',
                        'watch'
                     ]);

module.exports = gulp;