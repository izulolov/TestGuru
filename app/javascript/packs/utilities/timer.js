// app/javascript/packs/timer.js

document.addEventListener('DOMContentLoaded', function() {
  const timerElement = document.getElementById('timer');
  
  if (timerElement) {
    const remainingTime = parseInt(timerElement.dataset.remainingTime);
    const redirectUrl = timerElement.dataset.redirectUrl;
    
    if (!isNaN(remainingTime) && remainingTime > 0) {
      let timeLeft = remainingTime;
      
      const timerId = setInterval(function() {
        timeLeft -= 1;
        
        if (timeLeft <= 0) {
          clearInterval(timerId);
          timerElement.textContent = '0';
          
          // Показываем сообщение и перенаправляем на страницу результатов
          alert(document.querySelector('[data-time-expired-message]')?.dataset.timeExpiredMessage || 'Время истекло!');
          window.location.href = redirectUrl;
        } else {
          timerElement.textContent = timeLeft;
          
          // Изменение цвета таймера, когда осталось мало времени
          if (timeLeft < 30) {
            timerElement.classList.add('text-danger');
          } else if (timeLeft < 60) {
            timerElement.classList.add('text-warning');
          }
        }
      }, 1000);
    }
  }
});
