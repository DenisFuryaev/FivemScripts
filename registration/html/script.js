$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "enableui") {
            if (item.enable == true) {
                $("#container").show()
            } else {
                $("#container").hide()
            }
        }
    })

    $("#container").hide()

    $("#exit").click(function () {
        $.post('http://registration/exit', JSON.stringify({}));
        return
    })

    $("#submit").click(function () {
        var firstname_length = $("#firstname").val().length

        if  (firstname_length > 40) {
            return
        } else if (!firstname_length) {
            return
        }

        $.post('http://registration/submit', JSON.stringify({
            firstname: $("#firstname").val(),
            lastname: $("#lastname").val()
        }));
        return
    })

    document.onkeyup = function (data) {
        if (data.which == 27) { // Escape key
            $.post('http://registration/exit', JSON.stringify({}));
        }
    };
})