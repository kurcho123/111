$(document).ready(function () {
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.display == 'viewRegistration') {
            $('#1').text(item.citizenID)
            $('#2').text(item.citizenName)
            $('#3').text(item.registeredPLate)
            $('#4').text(item.vehicleMModel)
            if (item.registrationExpire == '') {
                $('#conditional').hide()
            } else {
                $('#conditional').show()
                $('#5').text(item.registrationExpire)
            }
            $('#vehiclerc').fadeIn()
        }
        else if (item.display == 'viewInsurance') {
            $('#1i').text(item.citizenID)
            $('#2i').text(item.citizenName)
            $('#3i').text(item.registeredPLate)
            $('#4i').text(item.vehicleMModel)
            $('#5i').text(item.insuranceDate)
            $('#6i').text(item.insuranceExpire)
            $('#vehicleinsurance').fadeIn()
        }
        else if (item.display == 'viewMot') {
            $('#1m').text(item.citizenID)
            $('#2m').text(item.citizenName)
            $('#3m').text(item.registeredPLate)
            $('#4m').text(item.vehicleMModel)
            if (item.motExpire == '') {
                $('#conditional').hide()
            } else {
                $('#conditional').show()
                $('#5m').text(item.motExpire)
            }
            $('#vehiclemot').fadeIn()
        }
        else if (item.display == 'viewHealthInsurance') {
            $('#1p').text(item.citizenID)
            $('#2p').text(item.citizenName)
            $('#3p').text(item.insuranceDate)
            $('#4p').text(item.insuranceExpire)
            $('#healthinsurance').fadeIn()
        }
        else if (item.action == 'close') {
            $('#healthinsurance').fadeOut()
        }
    })
})

