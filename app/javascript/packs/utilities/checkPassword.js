document.addEventListener('turbolinks:load', function() {
  var password = document.getElementById('user_password')
  var confirmation = document.getElementById('user_password_confirmation')
  if (password && confirmation){
    password.addEventListener("input", checkPasswords)
    confirmation.addEventListener("input", checkPasswords)
  }
})

function checkPasswords(){
  var password = document.getElementById('user_password')
  var confirmation = document.getElementById('user_password_confirmation')

  var octiconCheckCircle = document.querySelector('.octicon-check-circle')

  if (!password.value || !confirmation.value) {
    octiconCheckCircle.classList.add('hide')
    confirmation.style.borderColor = ''
    return
  }

  if (password.value == confirmation.value) {
    octiconCheckCircle.classList.remove('hide')
    octiconCheckCircle.classList.remove('red')
    octiconCheckCircle.classList.add('green')
    confirmation.style.borderColor = 'green'
  } else {
    octiconCheckCircle.classList.remove('hide')
    octiconCheckCircle.classList.remove('green')
    octiconCheckCircle.classList.add('red')
    confirmation.style.borderColor = 'red'
  }
}
