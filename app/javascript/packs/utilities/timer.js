document.addEventListener('turbolinks:load', function() {
  const timerElement = document.querySelector('.timer');
  
  if (timerElement) {
    const remainingSeconds = parseInt(timerElement.dataset.remainingTime);
    
    if (remainingSeconds > 0) {
      let timeLeft = remainingSeconds;
      
      const timerId = setInterval(function() {
        timeLeft -= 1;
        
        if (timeLeft <= 0) {
          clearInterval(timerId);
          // Автоматическая отправка формы при истечении времени
          document.querySelector('.form-with-questions').submit();
          return;
        }
        
        const minutes = Math.floor(timeLeft / 60);
        const seconds = timeLeft % 60;
        
        timerElement.textContent = `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        
        // Добавляем визуальное предупреждение, когда осталось мало времени (менее 30 секунд)
        if (timeLeft <= 30) {
          timerElement.classList.remove('bg-info');
          timerElement.classList.add('bg-danger');
          timerElement.classList.add('blink');
        }
      }, 1000);
    }
  }
});
