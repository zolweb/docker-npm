var gulp = require('gulp');
var jshint = require('gulp-jshint');

gulp.task('default', function() {
    return gulp.src('./gulpfile.js')
        .pipe(jshint())
        .pipe(jshint.reporter('default'));
});
