document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('.click')
  if (control) {control.addEventListener('click', sortByTestTitle)}
})

function sortByTestTitle() {
  var mainDiv = document.querySelector('.div-with-all-test')

  // NodeList
  // https://developer.mozilla.org/ru/docs/Web/API/NodeList
  var allDivsOnMainDiv = mainDiv.querySelectorAll('.card-div')
  var sortedAllDivsOnMainDiv = []
  
  // select all divs(each div is a card) starting from the first
  for (var i = 0; i < allDivsOnMainDiv.length; i++) {
    sortedAllDivsOnMainDiv.push(allDivsOnMainDiv[i])
  }

  if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
    sortedAllDivsOnMainDiv.sort(compareTitlesAsc)
    this.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.querySelector('.octicon-arrow-down').classList.add('hide')
  } else {
    sortedAllDivsOnMainDiv.sort(compareTitlesDesc)
    this.querySelector('.octicon-arrow-down').classList.remove('hide')
    this.querySelector('.octicon-arrow-up').classList.add('hide')
  }

  var sortedDiv = document.createElement('div')
  sortedDiv.setAttribute('class', 'row pt-3 div-with-all-test')
  sortedDiv.appendChild(allDivsOnMainDiv[0])
  
  for (var i = 0; i < sortedAllDivsOnMainDiv.length; i++) {
    sortedDiv.appendChild(sortedAllDivsOnMainDiv[i])
  }
  
  mainDiv.parentNode.replaceChild(sortedDiv, mainDiv)
}

function compareTitlesAsc(card1, card2) {
  var testTitle1 = card1.querySelector('h5').textContent
  var testTitle2 = card2.querySelector('h5').textContent
  
  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0
}

function compareTitlesDesc(card1, card2) {
  var testTitle1 = card1.querySelector('h5').textContent
  var testTitle2 = card2.querySelector('h5').textContent

  if (testTitle1 < testTitle2) { return 1 }
  if (testTitle1 > testTitle2) { return -1 }
  return 0
}
