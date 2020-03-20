let file = doument.getElementById('file');
let reader = new FileReader();

reader.addEventListener('load',function(e){
  document.getElementById('result').src = reader.result;
},false);