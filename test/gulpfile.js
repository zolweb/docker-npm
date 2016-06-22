var gulp = require('gulp');
var jshint = require('gulp-jshint');
var gulp   = require('gulp');

gulp.task('default', function() {
    return gulp.src('./gulpfile.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});
