gulp           = require 'gulp'
es             = require 'event-stream'
argvModule     = require 'yargs'
gutil          = require 'gulp-util'
copy           = require 'gulp-copy'
clean          = require 'gulp-clean'
gulpif         = require 'gulp-if'
stylus         = require 'gulp-stylus'
cssmin         = require 'gulp-minify-css'
concat         = require 'gulp-concat'
uglify         = require 'gulp-uglify'
ngAnnotate     = require 'gulp-ng-annotate'
autoprefix     = require 'gulp-autoprefixer'
coffee         = require 'gulp-coffee'
jade           = require 'gulp-jade'
sourcemaps     = require 'gulp-sourcemaps'
svgsprite      = require 'gulp-svg-sprite'
svgmin         = require 'gulp-svgmin'
imagemin       = require 'gulp-imagemin'
templateCache  = require 'gulp-angular-templatecache'
rspModule      = require 'remove-svg-properties'
connect        = require 'gulp-connect'
livereload     = require 'gulp-livereload'
checkUnusedCss = require 'gulp-check-unused-css'
coffeelint     = require 'gulp-coffeelint'

argv = argvModule.argv
rsp  = rspModule.stream

styles =
  all: 'styles/**/*.styl'
  mobile: 'styles/app/mobile/main.styl'
  desktop: 'styles/app/desktop/main.styl'
  vendor: 'styles/vendor/*.css'
  dest: 'public/stylesheets'
  destFile: 'public/stylesheets/style.css'

scripts =
  all: 'scripts/**/*.coffee'
  app: 'scripts/app/app.coffee'
  mobile: 'scripts/app/mobile/**/*.coffee'
  desktop: 'scripts/app/desktop/**/*.coffee'
  common: 'scripts/app/common/**/*.coffee'
  vendor: 'scripts/vendor/**/*.js'
  dest: 'public/scripts/'

templates =
  watch: 'templates/**/*.jade'
  mobile: 'templates/mobile/**/*.jade'
  desktop: 'templates/desktop/**/*.jade'
  dest: 'public/templates/'

fonts =
  all: 'fonts/**/*'
  dest: 'public/'

images =
  all: 'images/**/*'
  dest: 'public/'

icons =
  all: 'icons/**/*.svg'
  dest: 'public/icons/'


console.log 'USING ' + (if argv.production then 'PRODUCTION' else 'DEVELOPMENT') + ' SETTINGS'

processStyles = (src, outputName) ->
  stylesheets = gulp.src(src)
    .pipe(stylus())
    .on('error', gutil.log)

  vendor = gulp.src(styles.vendor)
  es.concat(vendor, stylesheets).on('error', gutil.log)
    .pipe(concat(outputName))
    .pipe(cssmin())
    .pipe(autoprefix('last 1 version'))
    .pipe(gulp.dest(styles.dest))
    .pipe livereload()

processScripts = (src, outputName) ->
  gulp.src(scripts.vendor)
    .pipe(concat('vendor.js'))
    .pipe(uglify())
    .pipe gulp.dest(scripts.dest)

  gulp.src(src)
    .pipe(gulpif(!argv.production, sourcemaps.init()))
    .pipe(coffee(bare: true))
    .pipe(concat(outputName))
    .pipe(ngAnnotate(add: true))
    .pipe(uglify())
    .pipe(gulpif(!argv.production, sourcemaps.write()))
    .pipe(gulp.dest(scripts.dest))
    .pipe livereload()

processTemplates = (src, outputName) ->
  gulp.src(src).pipe(jade()).pipe(templateCache(outputName, standalone: true)).pipe(gulp.dest(templates.dest)).pipe livereload()


gulp.task 'clean', ->
  gulp.src('public', read: false)
    .pipe clean()

gulp.task 'icons', ->
  gulp.src(icons.all)
    .pipe(rsp.remove(properties: [ rsp.PROPS_FILL ]))
    .pipe(svgsprite(mode: symbol: true))
    .pipe(svgmin(plugins: [ { cleanupIDs: false } ]))
    .pipe(gulp.dest(icons.dest))
    .pipe livereload()

gulp.task 'fonts', ->
  gulp.src(fonts.all)
    .pipe(copy(fonts.dest)).pipe livereload()

gulp.task 'images', ->
  gulp.src(images.all)
    .pipe(imagemin())
    .pipe(copy(images.dest))
    .pipe livereload()

gulp.task 'styles', ->
  processStyles styles.mobile, 'mobile.css'
  processStyles styles.desktop, 'desktop.css'

gulp.task 'scripts', ->
  processScripts [
    scripts.app
    scripts.common
    scripts.mobile
  ], 'mobile.js'
  processScripts [
    scripts.app
    scripts.common
    scripts.desktop
  ], 'desktop.js'

gulp.task 'lint-coffeescript', ->
  gulp.src(scripts.all)
    .pipe(coffeelint())
    .pipe coffeelint.reporter()

gulp.task 'templates', ->
  processTemplates templates.mobile, 'mobile.js'
  processTemplates templates.desktop, 'desktop.js'

gulp.task 'check-unused-css', ->
  gulp.src(styles.destFile)
    .pipe checkUnusedCss(files: 'public/*.html')

gulp.task 'connect', ->
  connect.server root: 'public/'

gulp.task 'watch', ->
  livereload(start: true)
  gulp.watch styles.all, [ 'styles' ]
  gulp.watch scripts.all, [ 'scripts' ]
  gulp.watch templates.watch, [ 'templates' ]
  gulp.watch icons.all, [ 'icons' ]

gulp.task 'build', [
  'styles'
  'scripts'
  'templates'
  'icons'
  'fonts'
  'images'
]

gulp.task 'quality', [
  'check-unused-css'
  'lint-coffeescript'
]

gulp.task 'default', [
  'build'
  'connect'
  'watch'
]

module.exports = gulp