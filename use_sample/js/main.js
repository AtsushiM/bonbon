// main
(function() {
    var template_thumb = $('#template-thumb').html();

    $.ajax({
        url: 'proxy.php',
        dataType: 'json',
        success: function(ret) {
            var i = 0,
                len = ret.length,
                html = '';

            for (; i < len; i++) {
                html += makeThumbs(ret[i]);
            }

            $('#loading').hide();

            $('body').append(html);
        }
    });

    function makeThumbs(obj) {
        var i = 0,
            name = obj['name'],
            img = obj['img'],
            len = img.length,
            tags = '',
            tag;

        for (; i < len; i++) {
            tag = template_thumb;

            tag = tag.replace('<%= href %>', img[i]['href']);
            tag = tag.replace('<%= alt %>', name);
            tag = tag.replace('<%= src %>', img[i]['src']);
            tags += tag;
        }

        return tags;
    }
}());
