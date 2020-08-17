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
        else if (item.type === "updatefuel") {
            $("#fuel").text("Fuel: " + item.fuel.toFixed(2))
            //console.log("here")
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 17) { // CTRL key
            $.post('http://car_control/exit', JSON.stringify({}));
        }
    };









// ---------| buttons |---------

$("#engine").click(function () {
    $.post('http://car_control/engine', JSON.stringify({}));
    return
})

$("#hood").click(function () {
    $.post('http://car_control/hood', JSON.stringify({}));
    return
})

$("#trunk").click(function () {
    $.post('http://car_control/trunk', JSON.stringify({}));
    return
})

$("#front_left").click(function () {
    $.post('http://car_control/front_left', JSON.stringify({}));
    return
})

$("#front_right").click(function () {
    $.post('http://car_control/front_right', JSON.stringify({}));
    return
})

$("#back_left").click(function () {
    $.post('http://car_control/back_left', JSON.stringify({}));
    return
})

$("#back_right").click(function () {
    $.post('http://car_control/back_right', JSON.stringify({}));
    return
})

})