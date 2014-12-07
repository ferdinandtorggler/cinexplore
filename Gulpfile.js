var gulp = require('gulp');

var es = require('event-stream');
var argv = require('yargs').argv;
var gutil = require('gulp-util');

var copy = require('gulp-copy');
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
var svgstore = require('gulp-svgstore');

var connect = require('gulp-connect');
var livereload = require('gulp-livereload');
var checkUnusedCss = require('gulp-check-unused-css');
var coffeelint = require('gulp-coffeelint');


var styles = {
    app: 'styles/main.styl',
    watch: 'styles/**/*.styl',
    vendor: 'styles/vendor/*.css',
    dest: 'public/stylesheets',
    destFile: 'public/stylesheets/style.css'
};

var scripts = {
    all: 'scripts/**/*.coffee',
    vendor: 'scripts/vendor/**/*.js',
    app: 'scripts/app/app.coffee',
    dest: 'public/scripts/'
};

var templates = {
    all: ['templates/angular/**/*.jade', 'index.jade'],
    watch: ['templates/**/*.jade', 'index.jade'],
    dest: 'public/'
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

gulp.task('icons', function () {
  var svgs = gulp.src(icons.all)
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
            .pipe(gulp.dest(icons.dest))
});

gulp.task('fonts', function () {
    gulp.src(fonts.all)
        .pipe(copy(fonts.dest));
});

gulp.task('images', function () {
    gulp.src(images.all)
        .pipe(copy(images.dest));
});

gulp.task('styles', function () {
    var app = gulp.src(styles.app).pipe(stylus()).on('error', gutil.log);
    var vendor = gulp.src(styles.vendor);
    return es.concat(vendor, app).on('error', gutil.log)
        .pipe(concat('style.css'))
        .pipe(cssmin())
        .pipe(autoprefix('last 1 version'))
        .pipe(gulp.dest(styles.dest));
});

gulp.task('scripts', function () {
    gulp.src(scripts.vendor).pipe(gulp.dest(scripts.dest));
    gulp.src(scripts.app, { read: false })
      .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
      })).on('error', gutil.log)
      .pipe(rename('app.js'))
      .pipe(ngAnnotate({
        add: true
      }))
      .pipe(gulpif(argv.production, uglify()))
      .pipe(gulp.dest(scripts.dest));
});

gulp.task('lint-coffeescript', function () {
    gulp.src(scripts.all)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter())
});

gulp.task('templates', function () {
    gulp.src(templates.all)
      .pipe(jade({}))
      .pipe(gulp.dest(templates.dest));
});

gulp.task('check-unused-css', function () {
    gulp.src(styles.destFile)
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
    gulp.watch(styles.watch, ['styles', 'check-unused-css']);
    gulp.watch(scripts.all, ['scripts', 'lint-coffeescript']);
    gulp.watch(templates.watch, ['templates']);
    gulp.watch(icons.all, ['icons']);
    gulp.watch('public/**').on('change', function (file) {
        server.changed(file.path);
    });
})

gulp.task('build', function () {
    gulp.start('styles', 'scripts', 'templates', 'icons', 'fonts', 'images');
});

gulp.task('default', [  'build',
                        'connect',
                        'check-unused-css',
                        'lint-coffeescript',
                        'watch'
                     ]);

module.exports = gulp;