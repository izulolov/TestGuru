document.addEventListener('turbolinks:load', function() {
  window.addEventListener('load', progressBar)
})

function progressBar(){
  formWhithQuestions = document.querySelector('.form-with-questions')
  progressBar = document.querySelector('.progress-bar')
 
  if(formWhithQuestions){
    countQuestionsInTest = formWhithQuestions.dataset.questionsCount
    questionPositionInTest = formWhithQuestions.dataset.questionPosition
    percent = (questionPositionInTest * 100 / countQuestionsInTest)
    progressBar.style.width = percent + "%"
    progressBar.textContent = percent + "%"
  }
}
