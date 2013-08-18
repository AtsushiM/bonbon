do () ->
    template_thumb = $('#template-thumb').html()

    makeThumbs = (item) ->
        name = item['name']
        img = item['img']
        tags = ''

        for i in img
            tags += template_thumb
                    .replace('<%= href %>', i['href'])
                    .replace('<%= alt %>', name)
                    .replace('<%= src %>', i['src'])

        tags

    $.ajax
        url: 'proxy.php'
        dataType: 'json'
        success: (ret) ->
            html = ''

            for item in ret
                html += makeThumbs item

            $('#loading').hide()
            $('body').append html

            return

    return
