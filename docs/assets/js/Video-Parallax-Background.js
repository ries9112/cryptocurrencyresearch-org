$(document).ready(function(){
    centerBgVideo();
});

$(window).on('resize', function(){
    centerBgVideo();
});

function centerBgVideo() {
    $('.video-parallax-container').each(function(){
        var container_height = $(this).height();
        var video_height = $(this).children('video').height();
        var margin_bottom = (video_height - container_height) / 2;
        var container_width = $(this).height();
        var video_width = $(this).children('video').height();
        var margin_right = (video_width - container_width) / 2;
        if (margin_bottom>0) {
            $(this).children('video').css('margin-bottom', margin_bottom+'px');
        }
        if (margin_right>0) {
            $(this).children('video').css('margin-right', margin_right+'px');
        }
    });
}