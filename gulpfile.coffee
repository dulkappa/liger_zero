gulp       = require 'gulp'
jade       = require 'gulp-jade'
browserify = require 'browserify'
riotify    = require 'riotify'
source     = require 'vinyl-source-stream'
plumber    = require 'gulp-plumber'
webserver  = require 'gulp-webserver'

gulp.task 'jade', ->
  gulp
  .src 'src/index.jade'
  .pipe plumber()
  .pipe jade()
  .pipe gulp.dest 'dist/'
  return

gulp.task 'browserify', ->
  browserify
    entries: [
      'src/js/components.js'
    ]
  .transform riotify,
    'template': 'jade'
  .bundle()
  .pipe gulp.dest 'dist/js/'
  return

gulp.task 'server', ->
  gulp
  .src 'dist'
  .pipe webserver
    port: 8888
    livereload: yes
  gulp.watch 'src/index.jade', ['jade']
  gulp.watch 'src/js/custom-tag/*', ['browserify']
  return

gulp.task 'default', ['server']