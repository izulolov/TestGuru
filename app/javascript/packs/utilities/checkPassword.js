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

  // Изначально поле confirm-password не доступно.
  // Как ввели чтото в поле password открывается поле confirm-password
  // Если в поле confirm-password юзер чтото ввел то начинается сравнивание
  // Если совпадают пароли убираем классы у иконки и правильно текста
  if (password.value !== ""){  
    confirmation.classList.remove('confirm-disable')
    if(confirmation.value.trim() !== ""){      
      if (password.value == confirmation.value){
        if (octiconXCircle.classList.contains("hide") && textWrong.classList.contains("failedpassword")){
          textCorrect.classList.remove("passedpassword")
          octiconCheckCircle.classList.remove('hide')  
        } else {
          octiconCheckCircle.classList.remove('hide')
          octiconXCircle.classList.add('hide')
          textWrong.classList.add("failedpassword")
        }
      }
      else {
        if (octiconCheckCircle.classList.contains("hide") && textCorrect.classList.contains("passedpassword")){
          textWrong.classList.remove("failedpassword")
          octiconXCircle.classList.remove('hide')
        } else {
          octiconXCircle.classList.remove('hide')
          octiconCheckCircle.classList.add('hide')
          textCorrect.classList.add("passedpassword")
        }
      }
    }
  }
}

