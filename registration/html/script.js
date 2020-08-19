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
        if (!checkInputs()) {
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

    function checkInputs() {
        var inputs_valid = true
        var firstname_length = $("#firstname").val().length
        var lastname_length = $("#lastname").val().length
        const firstname = document.getElementById("firstname")
        const lastname = document.getElementById("lastname")

        if  (firstname_length == 0) {
            setErrorFor(firstname, "first name can't be blank")
            inputs_valid = false
        } else if (firstname_length > 40) {
            setErrorFor(firstname, "first name lenght can't be more than 40 symbols")
            inputs_valid = false
        } else { setSuccessFor(firstname) }

        if  (lastname_length == 0) {
            setErrorFor(lastname, "last name can't be blank")
            inputs_valid = false
        } else if (lastname_length > 40) {
            setErrorFor(lastname, "last name lenght can't be more than 40 symbols")
            inputs_valid = false
        } else { setSuccessFor(lastname) }

        return inputs_valid
    }

    function setErrorFor(input, message) {
        const formControl = input.parentElement;
        const small = formControl.querySelector('small');
        formControl.className = 'form-control error';
        small.innerText = message;
    }

    function setSuccessFor(input) {
        const formControl = input.parentElement;
        formControl.className = 'form-control success';
    }
})