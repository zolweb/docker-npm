module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-contrib-jshint');
    grunt.initConfig({
        jshint: {
            all: ['Gruntfile.js']
        }
    });
    grunt.registerTask('default', ['jshint']);
};
