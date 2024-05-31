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
  
  // Изначально поле confirm-password не доступно.
  // Как ввели чтото в поле password открывается поле confirm-password
  // Если в поле confirm-password юзер чтото ввел то начинается сравнивание
  // Если совпадают пароли убираем классы у иконки и правильно текста
  if (password.value !== ""){
    
    confirmation.classList.remove('confirm-disable')
    if(confirmation.value.trim() !== ""){      
      if (password.value == confirmation.value){
        octiconCheckCircle.classList.remove('hide')
        textCorrect.classList.remove('passedpassword')
      } else {
        octiconXCircle.classList.remove('hide')
        textWrong.classList.remove('failedpassword')
        octiconCheckCircle.setAttribute('class', 'hide')
        textCorrect.setAttribute('class','passedpassword')
      }
    }
  }
}

