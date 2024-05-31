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
  var octiconXCircle = document.querySelector('.octicon-x-circle')
  
  var textCorrect = document.querySelector('.passedpassword')
  var textWrong = document.querySelector('.failedpassword')
  
  var msg = document.getElementById('message')
  
  if (password.value == confirmation.value){
    octiconCheckCircle.classList.remove('hide')
    textCorrect.classList.remove('passedpassword')
  }
  else{
    octiconXCircle.classList.remove('hide')
    textWrong.classList.remove('failedpassword')
  }
}
