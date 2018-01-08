(function( $ ) {
    
        //Function to animate slider captions 
        function doAnimations( elems ) {
            //Cache the animationend event in a variable
            var animEndEv = 'webkitAnimationEnd animationend';
            
            elems.each(function () {
                var $this = $(this),
                    $animationType = $this.data('animation');
                $this.addClass($animationType).one(animEndEv, function () {
                    $this.removeClass($animationType);
                });
            });
        }
        
        //Variables on page load 
        var $myCarousel = $('#carousel-example-generic'),
            $firstAnimatingElems = $myCarousel.find('.item:first').find("[data-animation ^= 'animated']");
            
        //Initialize carousel 
        $myCarousel.carousel();
        
        //Animate captions in first slide on page load 
        doAnimations($firstAnimatingElems);
        
        //Pause carousel  
        $myCarousel.carousel('pause');
        
        
        //Other slides to be animated on carousel slide event 
        $myCarousel.on('slide.bs.carousel', function (e) {
            var $animatingElems = $(e.relatedTarget).find("[data-animation ^= 'animated']");
            doAnimations($animatingElems);
        });  
        $('#carousel-example-generic').carousel({
            interval:3000,
            pause: "false"
        });
        
    })(jQuery);	
    


///google search

        (function() {
          var cx = '012902697259595331312:izyfjlodcqu';
          var gcse = document.createElement('script');
          gcse.type = 'text/javascript';
          gcse.async = true;
          //gcse.src = 'https://cse.google.com/cse.js?cx=' + cx;
          gcse.src = "/search.txt";
          var s = document.getElementsByTagName('script')[0];
          s.parentNode.insertBefore(gcse, s);
        })();
    
//main javascript


var criteriasinfo = [];
var weight = [];
var universities =[];
var filteruniindex = [];
var filtercriindex =[];
var totalfaculty =[];
var filteredfaculty =[]; 
var count=0;
var count1=0;
var count2=0;
var count3=0;
var counter =0;
var criserver =[];
var ranks=[];
var sum=0;
var val=0;
var criresults = [];
var temp=[];
var tempy =0;
var names = [];
var realnames = [];
var filteredweights=[];
var uni_urls =[];
var uni_name_string = [];
var sortcheck=1;
var progresscheck=true;
var resultscheck=true;
document.body.style.backgroundAttachment="fixed";

function backbutton()
{
var bck = document.getElementById('mybackbutton');
var nxt = document.getElementById('mymainbutton');
var hh = document.getElementById('homeHeading');

if(hh.innerHTML=="Select Criteria and assign weightages")
{

bck.style.display='none';
nxt.innerHTML="NEXT";
document.getElementById('homeHeading').innerHTML = "Enter URL's of universities";
document.getElementById('hidecriteria').style.display = 'none';
document.getElementById('hideuni').style.display = 'inline-block';
}
else if(hh.innerHTML=="Calculating Results...")
{
 
 document.getElementById('mybackbutton').innerHTML = 'Back';
 document.getElementById('hidecriteria').style.display = 'inline-block';
 document.getElementById('mymainbutton').style.display = 'inline-block';
 document.getElementById('homeHeading').innerHTML = "Select Criteria and assign weightages";
 document.getElementById('hideprogress').style.display='none';
 document.getElementById('mymainbutton').style.display = 'inline-block';
 progresscheck=false;
 resultscheck=false;

 var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {

  if (this.readyState == 4 && this.status == 200) {
    helo=this.responseText;
    };
    xhttp.open("GET", "/stopexecution", true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send();
  }
}
else if(hh.innerHTML=="Getting Initial information...")
{
  document.getElementById('mybackbutton').innerHTML = 'Back';
  document.getElementById('hidecriteria').style.display = 'inline-block';
  document.getElementById('mymainbutton').style.display = 'inline-block';
  document.getElementById('homeHeading').innerHTML = "Select Criteria and assign weightages";
  document.getElementById('hideprogress').style.display='none';
  document.getElementById('mymainbutton').style.display = 'inline-block';
  document.getElementById('getuninames').style.display='none';
  progresscheck=false;
  resultscheck=false;

}
else if(hh.innerHTML=="Results")
{
 
 document.getElementById('hidecriteria').style.display = 'inline-block';
 document.getElementById('mymainbutton').style.display = 'inline-block';
 document.getElementById('homeHeading').innerHTML = "Select Criteria and assign weightages";
 document.getElementById('hideprogress').style.display='none';
 document.getElementById('mymainbutton').style.display = 'inline-block';
 document.getElementById('table1').style.display = 'none';
 document.getElementById('hideresults').style.display='none';
 document.getElementById('checkboxes').style.display='none';
}

}
function mainbutton()
{
counter=0;
var mainbuttontext = document.getElementById('mymainbutton').innerHTML;
var totalunis=document.getElementById('url-table').rows.length;
if(mainbuttontext == "NEXT" )
{

if(totalunis==0)
{
 alert("Please enter atleast one university to continue");
}
else
{
 document.getElementById('mymainbutton').innerHTML = "CALCULATE RANKING";
 document.getElementById('hideuni').style.display = 'none';
 document.getElementById('hidecriteria').style.display = 'inline-block';
 document.getElementById('homeHeading').innerHTML = "Select Criteria and assign weightages";
 document.getElementById('mybackbutton').style.display = 'inline-block';
}

}
else if(mainbuttontext== "CALCULATE RANKING")
{

var cb1 = document.getElementById('cb1').checked;
var cb2 = document.getElementById('cb2').checked;
var cb3 = document.getElementById('cb3').checked;
var cb4 = document.getElementById('cb4').checked;
var cb5 = document.getElementById('cb5').checked;
var cb6 = document.getElementById('cb6').checked;
var cb7 = document.getElementById('cb7').checked;
var cb8 = document.getElementById('cb8').checked;
var cb9 = document.getElementById('cb9').checked;
var cb10 = document.getElementById('cb10').checked;
if(cb1==false && cb2==false && cb3==false && cb4==false && cb5==false && cb6==false && cb7==false && cb8==false && cb9==false && cb10==false)
{
 alert("Please select atleast one criteria to continue");
}
else
{
 
 document.getElementById('mybackbutton').innerHTML = 'Cancel';
 document.getElementById('hidecriteria').style.display = 'none';
 document.getElementById('mymainbutton').style.display = 'none';
 document.getElementById('homeHeading').innerHTML = "Getting Initial information...";
 document.getElementById('getuninames').style.display='inline-block';
 resultscheck=true;
 progresscheck=true;
 getArray();
 senddatatoserver();
 //getprogramscount();
 uni_urls=[];
 uni_name_string=[];
  totalfaculty=[];
 uni_urls = JSON.stringify(universities);
 var xhttp = new XMLHttpRequest();
 xhttp.onreadystatechange = function() {
  if (this.readyState == 4 && this.status == 200) {
    helo=this.responseText;
    uni_name_string = JSON.parse(helo);
    if(progresscheck==true)
    {
      progressfunction();
    }
  }
};
xhttp.open("GET", "/getuniname?second="+uni_urls, true);
xhttp.setRequestHeader("Content-type", "application/json");
xhttp.send();
      asad(counter);
    }
  }
  
}


function getArray() {
  
  var table1 = document.getElementById("url-table");
  var u;
  universities=[];
  var rows = table1.rows.length;
  if (rows > 1) {
    for (i = 1;i<table1.rows.length;i++) {
      universities.push(table1.rows[i].cells[1].innerHTML);
    }
  }
  var table2 = document.getElementById("criteria-table");
  var rows2 = table1.rows.length;
  if (rows > 1) {
    criteriasinfo = [];
    weight = [];
    var cbValue = document.getElementById("cb1").checked;
    if (cbValue == true) {
      var sel = document.getElementById("s1");
      var sv = sel.options[sel.selectedIndex].value;
      criteriasinfo.push("Total Faculty");
      weight.push(sv);
    }
    var cbValue = document.getElementById("cb2").checked;
    if (cbValue == true) {
      var sel = document.getElementById("s2");
      var sv = sel.options[sel.selectedIndex].value;
      weight.push(sv);
      criteriasinfo.push("Total PhD professors");
    }
    var cbValue = document.getElementById("cb3").checked;
    if (cbValue == true) {
     var sel = document.getElementById("s3");
     var sv = sel.options[sel.selectedIndex].value;
     weight.push(sv);
     criteriasinfo.push("Foreign qualified PhD professors");
   }
   var cbValue = document.getElementById("cb4").checked;
   if (cbValue == true) {
    var sel = document.getElementById("s4");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Research groups");
  }
  var cbValue = document.getElementById("cb5").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s5");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Programs offered");
  }
  var cbValue = document.getElementById("cb6").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s6");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Journals");
  }
  var cbValue = document.getElementById("cb7").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s7");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Ratio of full-time faculty to total faculty");
  }
  var cbValue = document.getElementById("cb8").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s8");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Ratio of PhD to full-time total faculty");
  }
  var cbValue = document.getElementById("cb9").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s9");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Books published");
  }
  var cbValue = document.getElementById("cb10").checked;
  if (cbValue == true) {
    var sel = document.getElementById("s10");
    var sv = sel.options[sel.selectedIndex].value;
    weight.push(sv);
    criteriasinfo.push("Conference papers");
  }
  
  }
  }
  


function sortTable(c)
{
  var table = document.getElementById("table1");
  for (var i=0;i< universities.length;i++)
  {
    for(var j=0;j<universities.length;j++)
    {

      if(parseInt(table.rows[i+3].cells[c+2].innerHTML) > parseInt(table.rows[j+3].cells[c+2].innerHTML) && sortcheck==0)
      {
        for(var k =1;k<criteriasinfo.length+3;k++)
        {
          var temp = table.rows[i+3].cells[k].innerHTML;
          table.rows[i+3].cells[k].innerHTML = table.rows[j+3].cells[k].innerHTML;
          table.rows[j+3].cells[k].innerHTML = temp;
        }
      }
      else if(sortcheck==1 && parseInt(table.rows[i+3].cells[c+2].innerHTML) < parseInt(table.rows[j+3].cells[c+2].innerHTML))
      {
        for(var k =1;k<criteriasinfo.length+3;k++)
        {
          var temp = table.rows[i+3].cells[k].innerHTML;
          table.rows[i+3].cells[k].innerHTML = table.rows[j+3].cells[k].innerHTML;
          table.rows[j+3].cells[k].innerHTML = temp;
        }
      }
    }
  }
  if(sortcheck==0)
  {
    sortcheck=1;
  }
  else
  {
    sortcheck=0;
  }
}


function sortFiltered(c)
{
  var table = document.getElementById("table1");
  for (var i=0;i< filteruniindex.length;i++)
  {
    for(var j=0;j<filteruniindex.length;j++)
    {

      if(parseInt(table.rows[i+3].cells[c+2].innerHTML) > parseInt(table.rows[j+3].cells[c+2].innerHTML) && sortcheck==0)
      {
        for(var k =1;k<filtercriindex.length+3;k++)
        {
          var temp = table.rows[i+3].cells[k].innerHTML;
          table.rows[i+3].cells[k].innerHTML = table.rows[j+3].cells[k].innerHTML;
          table.rows[j+3].cells[k].innerHTML = temp;
        }
      }
      else if(sortcheck==1 && parseInt(table.rows[i+3].cells[c+2].innerHTML) < parseInt(table.rows[j+3].cells[c+2].innerHTML))
      {
        for(var k =1;k<filtercriindex.length+3;k++)
        {
          var temp = table.rows[i+3].cells[k].innerHTML;
          table.rows[i+3].cells[k].innerHTML = table.rows[j+3].cells[k].innerHTML;
          table.rows[j+3].cells[k].innerHTML = temp;
        }
      }
    }
  }
  if(sortcheck==0)
  {
    sortcheck=1;
  }
  else
  {
    sortcheck=0;
  }
}

function filteredresults()
{
  filteruniindex = [];
  filtercriindex = [];
  filteredfaculty = [];
  var filteredcri = [];
  filteredweights = [];
  var chk_arr1 =  document.getElementsByName("unicheck");
  var chklength1 = chk_arr1.length;
  for(k=0;k< chklength1;k++)
  {
    if(chk_arr1[k].checked == true)
    {
      filteruniindex.push(k);
    }
  }

  var chk_arr2 =  document.getElementsByName("cricheck");
  var chklength2 = chk_arr2.length;             
  var row;
  var cell1;
  var cell2;
  var cell3;
  var un;
  var cr;
  for(k=0;k<chklength2;k++)
  {
    if(chk_arr2[k].checked == true)
    {
      filteredcri.push(k);
      if(chk_arr2[k].value == "Total Faculty")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(0);
      }
      else if(chk_arr2[k].value == "Total PhD professors")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(1);
      }
      else if(chk_arr2[k].value == "Foreign qualified PhD professors")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(2);
      }
      else if(chk_arr2[k].value == "Research groups")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(3);
      }
      else if(chk_arr2[k].value == "Programs offered")
      {
        //alert(chk_arr2[k].value);
        //getprogramscount(i);
        filtercriindex.push(4);
      }
      else if(chk_arr2[k].value == "Journals")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(5);
      }
      else if(chk_arr2[k].value == "Ratio of full-time faculty to total faculty")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(6);
      }
      else if(chk_arr2[k].value == "Ratio of PhD to full-time total faculty")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(7);
      }
      else if(chk_arr2[k].value== "Books published")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(8);
      }
      else if(chk_arr2[k].value == "Conference papers")
      {
        //alert(chk_arr2[k].value);
        filtercriindex.push(9);
      }
      filteredweights.push(k);
    }
  }
  var totaluni = filteruniindex.length ;
  var totalcrit = filtercriindex.length;
  if(totaluni > 0 && totalcrit > 0)
  {
    count1 = 0;
    var table = document.getElementById('table1');
//document.getElementById('ranking_table').style.display='inline-block';
    table.style.display='inline-block';
    table.innerHTML="";
  // Create an empty <tr> element and add it to the 1st position of the table:
    rankfilteredunis();
    if(totaluni>0)
     {
    var row = table.insertRow(count1);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.padding="10px 10px 10px 10px";
    var cell2 = row.insertCell(1);
    cell2.style.padding="10px 10px 10px 10px";
    var cell3 = row.insertCell(2);
    cell3.style.padding="10px 10px 10px 10px";
    var cell4 = row.insertCell(3);
    cell4.style.padding="10px 10px 10px 10px";
    cell1.rowSpan =3;
    cell2.rowSpan =3;
    cell3.colSpan = totalcrit;
    cell4.rowSpan =3;

// Add some text to the new cells:
cell1.innerHTML = "SNO";
cell1.style.textDecoration="underline";
cell1.style.paddingTop = "120px";
cell2.innerHTML = "University";
cell2.style.paddingTop = "120px";
cell2.style.textDecoration="underline";
cell3.innerHTML = "Weights";
cell3.style.textAlign="center";
cell3.style.textDecoration="underline";
cell4.innerHTML = "Ranking";
cell4.style.textDecoration="underline";

count1++;
row = table.insertRow(count1);
row.style.color="orange";
row.style.fontSize="20px";
row.style.backgroundColor="#5b6472";
for(var y =0;y<filteredweights.length;y++)
{
  cell1 = row.insertCell(y);
  cell1.style.padding="10px 10px 10px 10px";
  cell1.innerHTML= weight[filteredweights[y]];
  cell1.style.textAlign="center";
}

count1++;
row = table.insertRow(count1);
row.style.color="orange";
row.style.fontSize="20px";
row.style.backgroundColor="#5b6472";
for(var r =0;r<totalcrit;r++)
{
  cell1 = row.insertCell(r);
  cell1.style.color="#428bcb";
  cell1.style.textAlign="center";
  cell1.style.setProperty("-webkit-transition", "color 1s");
  cell1.style.setProperty("-moz-transition", "color 1s");
  cell1.style.setProperty("-ms-transition", "color 1s");
  cell1.style.setProperty("-o-transition", "color 1s");
  cell1.style.setProperty("transition", "color 1s");
  cell1.onmouseover = function() 
  {
    this.style.color="blue";
  }
  cell1.onmouseout = function()
  {
    this.style.color="#428bcb";
  }
  cell1.style.padding="10px 10px 10px 10px";
  cell1.innerHTML= criteriasinfo[filteredcri[r]];
  var myrow;
  var mycol;
  cell1.addEventListener("click", function(){
    mycol =this.cellIndex;
    myrow = this.parentNode.rowIndex;
    sortFiltered(mycol);
    }, false);
  cell1.style.cursor = "pointer";
}

count1++;
for(var i =0; i<totaluni; i++)
{
  row = table.insertRow(count1);
  cell1 = row.insertCell(0);
  cell1.style.padding="10px 10px 10px 10px";
  cell1.innerHTML = count1-2;
  cell2 = row.insertCell(1);
  cell2.style.padding="10px 10px 10px 10px";
  cell2.innerHTML = uni_name_string[filteruniindex[i]];
  if(count1==1||count1==3)
  {
    row.style.backgroundColor="#edf0f2";
  }
  else
  {
    row.style.backgroundColor="#ccdfe8";
  }

  for(var j = 0; j<totalcrit;j++)
  {
    cell3 = row.insertCell(j+2);

    cell3.style.padding="10px 10px 10px 10px";
    cell3.style.color="#428bcb";
    cell3.style.textDecoration="underline";
    cell3.style.textAlign="center";
    cell3.onmouseover = function() 
    {
      this.style.color="blue";
    }
    cell3.onmouseout = function()
    {
      this.style.color="#428bcb";
    }
    cell3.style.setProperty("-webkit-transition", "color 1s");
    cell3.style.setProperty("-moz-transition", "color 1s");
    cell3.style.setProperty("-ms-transition", "color 1s");
    cell3.style.setProperty("-o-transition", "color 1s");
    cell3.style.setProperty("transition", "color 1s");
    if(filtercriindex[j]==4)
    {
      cell3.innerHTML = totalfaculty[filteruniindex[i]][filtercriindex[j]];        
    }
    else
    {
      cell3.innerHTML = totalfaculty[filteruniindex[i]][filtercriindex[j]][totalfaculty[filteruniindex[i]][filtercriindex[j]].length-1];  
    }
        var myrow;
        var mycol;
        cell3.addEventListener("click", function(){
          mycol =this.cellIndex;
          myrow = this.parentNode.rowIndex;
          var tex = table.rows[2].cells[mycol-2].innerHTML;
          displayChart1(myrow,tex);}, false);
        cell3.style.cursor = "pointer";
      }
// Add some text to the new cells:
cell4= row.insertCell(totalcrit+2);
cell4.style.padding="10px 10px 10px 10px";
cell4.innerHTML=criresults[i];

count1++;
}
document.getElementById('checkboxes').style.display='none';
document.getElementById('rb2').checked=false;
}
else
{
}
sortFiltered(totalcrit);
}
else{
  alert("Please select atleast one university and one criteria");
  
}
}

function calculateRanking()
{
  //alert(totalfaculty);
  var row;
  var cell1;
  var cell2;
  var cell3;
  var un;
  var cr;
  count1=0;
  var myflag = true;
/*var table1 = document.getElementById("url-table");
var u ;
var rows = table1.rows.length;
if(rows>1)
{
  for ( var i = 1; i < table1.rows.length; i++)
  {
    universities.push({uni: table1.rows[n].cells[1].innerHTML});
  }
} */

//document.getElementById('ranking_table').style.display='inline-block';
var table = document.getElementById('table1');
table.style.setProperty("-webkit-animation", "fadeIn 1s");
table.style.setProperty("animation", "fadeIn 1s");
table.style.display="inline-block";
table.innerHTML="";
rankunis();
// Create an empty <tr> element and add it to the 1st position of the table:
var totaluni = universities.length ;
var totalcrit = criteriasinfo.length;

if(totaluni>0)
{
  var row = table.insertRow(count1);
  row.style.color="orange";
  row.style.fontSize="20px";
  row.style.backgroundColor="#5b6472";
  var cell1 = row.insertCell(0);
  cell1.style.width="auto";
  cell1.style.padding="10px 10px 10px 10px";
  var cell2 = row.insertCell(1);
  cell2.style.padding="10px 10px 10px 10px";
  var cell3 = row.insertCell(2);
  cell3.style.padding="10px 10px 10px 10px";
  var cell4 = row.insertCell(3);
  cell4.style.padding="10px 10px 10px 10px";
  cell1.rowSpan =3;
  cell2.rowSpan =3;
  cell4.rowSpan =3;
  cell3.colSpan = totalcrit;
  cell1.innerHTML ="Sno."
  cell1.style.paddingTop = "120px";
  cell2.innerHTML = "University";
  cell2.style.paddingTop = "120px";
  cell3.innerHTML = "Weights";
  cell3.style.textAlign="center";
  cell4.innerHTML = "Ranking";
  cell1.style.textDecoration="underline";
  cell2.style.textDecoration="underline";
  cell3.style.textDecoration="underline";
  cell4.style.textDecoration="underline";
  count1++;
  row = table.insertRow(count1);
  row.style.color="orange";
  row.style.fontSize="20px";
  row.style.backgroundColor="#5b6472";
  for(var y =0;y<weight.length;y++)
  {
    cell1 = row.insertCell(y);
    cell1.innerHTML= weight[y];
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
  }

  count1++;
  row = table.insertRow(count1);
  row.style.color="orange";
  row.style.fontSize="20px";
  row.style.backgroundColor="#5b6472";
  for(var r =0;r<criteriasinfo.length;r++)
  {
    cell1 = row.insertCell(r);
    cell1.style.padding="10px 10px 10px 10px";
    cell1.style.color="#428bcb";
    cell1.style.textAlign="center";
    cell1.style.setProperty("-webkit-transition", "color 1s");
    cell1.style.setProperty("-moz-transition", "color 1s");
    cell1.style.setProperty("-ms-transition", "color 1s");
    cell1.style.setProperty("-o-transition", "color 1s");
    cell1.style.setProperty("transition", "color 1s");
    cell1.onmouseover = function() 
    {
      this.style.color="blue";
    }
    cell1.onmouseout = function()
    {
      this.style.color="#428bcb";
    }
    cell1.innerHTML= criteriasinfo[r];
    cell1.addEventListener("click", function(){
      myrow =this.parentNode.rowIndex;
      mycol =this.cellIndex;
      sortTable(mycol); } , false);
    cell1.style.cursor = "pointer";
  }
  count1++;
} 
for(var i =0; i<totaluni; i++)
{
  row = table.insertRow(count1);
  if(count1==1||count1==3)
  {
    row.style.backgroundColor="#edf0f2";
  }
  else
  {
    row.style.backgroundColor="#ccdfe8";
  }
  cell1 = row.insertCell(0);
  cell1.innerHTML = count1-2;
  cell1.style.padding="10px 10px 10px 10px";
  cell2 = row.insertCell(1);
  cell2.innerHTML = uni_name_string[i];
  cell2.style.padding="10px 10px 10px 10px";
  
  for(var j = 0; j<totalcrit;j++)
  {
    myflag=true;
    cell3 = row.insertCell(j+2);
    cell3.style.padding="10px 10px 10px 10px";
    cell3.style.color="#428bcb";
    cell3.style.textDecoration="underline";
    cell3.style.textAlign="center";
    cell3.onmouseover = function() 
    {
      this.style.color="blue";
    }
    cell3.onmouseout = function()
    {
      this.style.color="#428bcb";
    }
    cell3.style.setProperty("-webkit-transition", "color 1s");
    cell3.style.setProperty("-moz-transition", "color 1s");
    cell3.style.setProperty("-ms-transition", "color 1s");
    cell3.style.setProperty("-o-transition", "color 1s");
    cell3.style.setProperty("transition", "color 1s");
    if(table.rows[2].cells[j].innerHTML == "Total Faculty")
    {
      if(totalfaculty[i][0]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][0];
      }
      
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Total PhD professors")
    {
      if(totalfaculty[i][1]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][1];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Foreign qualified PhD professors")
    {
      if(totalfaculty[i][2]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][2];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Research groups")
    {
      if(totalfaculty[i][3]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][3][totalfaculty[i][3].length-1];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Programs offered")
    {
      getprogramscount(i);
      cell3.innerHTML = totalfaculty[i][4];
      cell3.style.color = "orange";
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Journals")
    {
      if(totalfaculty[i][5]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][5][totalfaculty[i][5].length-1];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Ratio of full-time faculty to total faculty")
    {
      if(totalfaculty[i][6]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][6];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Ratio of PhD to full-time total faculty")
    {
      if(totalfaculty[i][7]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][7];
      }      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Books published")
    {
      if(totalfaculty[i][8]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][8][totalfaculty[i][8].length-1];
      }
      //cell3.innerHTML = "1";
    }
    else if(table.rows[2].cells[j].innerHTML == "Conference papers")
    {
      if(totalfaculty[i][9]=="$")
      {
        cell3.innerHTML = "Error";
        cell3.style.backgroundColor="red";
        myflag=false;
      }
      else
      {
        cell3.innerHTML = totalfaculty[i][9][totalfaculty[i][9].length-1];
      }
      //cell3.innerHTML = "1";
    }
    var myrow;
    var mycol;
    if(myflag==true)
    {
    cell3.addEventListener("click", function(){
      myrow =this.parentNode.rowIndex;
      mycol =this.cellIndex;
      var tex = table.rows[2].cells[mycol-2].innerHTML;
      displayChart(myrow,tex);}  , false);
    cell3.style.cursor = "pointer";
    }
    else 
    {
      cell3.addEventListener("click", function(){
        displayerror();}  , false);
      cell3.style.cursor = "pointer";
    }
  }
  cell4= row.insertCell(totalcrit+2);
  cell4.style.padding="10px 10px 10px 10px";
  cell4.style.textAlign="center";
  cell4.innerHTML=criresults[i];
  count1++;
}
sortTable(criteriasinfo.length);
// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
var l = document.getElementById("table1").rows.length;
for(var t=0;t<l;t++)
{
  table.rows[t].firstChild.style.borderTopLeftRadius="0px";
  table.rows[t].lastChild.style.borderTopRightRadius="0px";
  table.rows[t].firstChild.style.borderBottomLeftRadius="0px";
  table.rows[t].lastChild.style.borderBottomRightRadius="0px";
}
table.rows[0].firstChild.style.borderTopLeftRadius="10px";
table.rows[0].lastChild.style.borderTopRightRadius="10px";
table.rows[l-1].firstChild.style.borderBottomLeftRadius="10px";
table.rows[l-1].lastChild.style.borderBottomRightRadius="10px";
}

function displayerror()
{
  alert("Something went wrong");
}
function rankfilteredunis()
{
var table = document.getElementById('table1');

for(var n=0;n<filteruniindex.length;n++)
{
  sum =0;
  for(var i=0;i<filtercriindex.length;i++)
  {
    if(criteriasinfo[filtercriindex[i]] == "Total Faculty")
    {
      val = totalfaculty[filteruniindex[n]][0][totalfaculty[n][0].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Total PhD professors")
    {
      val = totalfaculty[filteruniindex[n]][1][totalfaculty[n][1].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Foreign qualified PhD professors")
    {
      val = totalfaculty[filteruniindex[n]][2][totalfaculty[n][2].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Research groups")
    {
      val = totalfaculty[filteruniindex[n]][3][totalfaculty[n][3].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Programs offered")
    {
      val = totalfaculty[filteruniindex[n]][4][totalfaculty[n][4].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Journals")
    {
      val = totalfaculty[filteruniindex[n]][5][totalfaculty[n][5].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Ratio of full-time faculty to total faculty")
    {
      val = totalfaculty[filteruniindex[n]][6][totalfaculty[n][6].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Ratio of PhD professors to total full-time faculty")
    {
      val = totalfaculty[filteruniindex[n]][7][totalfaculty[n][7].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Books published")
    {
      val = totalfaculty[filteruniindex[n]][8][totalfaculty[n][8].length-1];
    }
    else if(criteriasinfo[filtercriindex[i]] == "Conference papers")
    {
      val = totalfaculty[filteruniindex[n]][9][totalfaculty[n][9].length-1];
    }
    tempy = val*weight[i];
    sum = sum+tempy;

  }
  ranks[n]=sum;
}
for(var t=0;t<ranks.length;t++)
{
  criresults[t]=1;
}

for(var a=0;a<ranks.length;a++)
{
  for(var b=0;b<ranks.length;b++)
  {
    if(ranks[b]>ranks[a])
    {
      criresults[a]++;
    }
  }
}

}
function rankunis()
{
var table = document.getElementById('table1');

for(var n=0;n<universities.length;n++)
{
  sum =0;
  for(var i=0;i<criteriasinfo.length;i++)
  {
    if(criteriasinfo[i] == "Total Faculty")
    {
      val = totalfaculty[n][0][totalfaculty[n][0].length-1];
    }
    else if(criteriasinfo[i] == "Total PhD professors")
    {
      val = totalfaculty[n][1][totalfaculty[n][1].length-1];
    }
    else if(criteriasinfo[i] == "Foreign qualified PhD professors")
    {
      val = totalfaculty[n][2][totalfaculty[n][2].length-1];
    }
    else if(criteriasinfo[i] == "Research groups")
    {
      val = totalfaculty[n][3][totalfaculty[n][3].length-1];
    }
    else if(criteriasinfo[i] == "Programs offered")
    {
      getprogramscount(n);
      val = totalfaculty[n][4][totalfaculty[n][4].length-1];
    }
    else if(criteriasinfo[i] == "Journals")
    {
      val = totalfaculty[n][5][totalfaculty[n][5].length-1];
    }
    else if(criteriasinfo[i] == "Ratio of full-time faculty to total faculty")
    {
      val = totalfaculty[n][6][totalfaculty[n][6].length-1];
    }
    else if(criteriasinfo[i] == "Ratio of PhD professors to total full-time faculty")
    {
      val = totalfaculty[n][7][totalfaculty[n][7].length-1];
    }
    else if(criteriasinfo[i] == "Books published")
    {
      val = totalfaculty[n][8][totalfaculty[n][8].length-1];
    }
    else if(criteriasinfo[i] == "Conference papers")
    {
      val = totalfaculty[n][9][totalfaculty[n][9].length-1];
    }
    tempy = val*weight[i];
    sum = sum+tempy;
  }
  ranks[n]=sum;
}
for(var t=0;t<ranks.length;t++)
{
  criresults[t]=1;
}

for(var a=0;a<ranks.length;a++)
{
 for(var b=0;b<ranks.length;b++)
 {
  if(ranks[b]>ranks[a])
  {
   criresults[a]++;
 }
}
}
}

function senddatatoserver()
{
criserver=[];
for(var i=0;i<criteriasinfo.length;i++)
{
 if(criteriasinfo[i] == "Total Faculty")
 {
  criserver.push("fac");
}
else if(criteriasinfo[i] == "Total PhD professors")
{
  criserver.push("phd");
}
else if(criteriasinfo[i] == "Foreign qualified PhD professors")
{
  criserver.push("fphd");
}
else if(criteriasinfo[i] == "Research groups")
{
  criserver.push("rg");
}
else if(criteriasinfo[i] == "Programs offered")
{
  criserver.push("po");
}
else if(criteriasinfo[i] == "Journals")
{
  criserver.push("tp");
}
else if(criteriasinfo[i] == "Ratio of full-time faculty to total faculty")
{
  criserver.push("rv_total");
}
else if(criteriasinfo[i] == "Ratio of PhD to full-time total faculty")
{
  criserver.push("rt_phd");
}
else if(criteriasinfo[i] == "Books published")
{
  criserver.push("bp");
}
else if(criteriasinfo[i] == "Conference papers")
{
  criserver.push("cp");
}
}



}

function asad(ll)
{
  var temp =[];
  temp.push(universities[ll]);
  loadDoc(temp,criserver);
}


function addUrlFunc()
{
 
 var u = document.getElementById('urlBar');
 var uni = document.getElementById('urlBar').value;
 var check = validateUrl(uni);
 if(check==true)
 {
     if(count3<5)
     {
   var table = document.getElementById('url-table');
   table.style.setProperty("-webkit-animation", "fadeIn 1s");
   table.style.setProperty("animation", "fadeIn 1s");
      table.style.maxWidth="800px";
   if(count3==0)
   {
    var row = table.insertRow(count3);
    row.style.setProperty("-webkit-animation", "fadeIn 1s");
    row.style.setProperty("animation", "fadeIn 1s");
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    cell1.style.whiteSpace='nowrap';
    cell1.style.padding="10px 10px 10px 10px";
    cell2.style.whiteSpace='nowrap';
    cell2.style.textOverflow="ellipsis";
    cell2.style.overflow="hidden";
    cell2.style.maxWidth="1px";
    cell2.style.padding="10px 10px 10px 10px";
    cell3.style.whiteSpace='nowrap';
    cell3.style.padding="10px 10px 10px 10px";


    cell1.innerHTML = "SNO";
    cell1.style.textDecoration="underline";
    cell2.innerHTML = "University";
    cell2.style.textDecoration="underline";
    count3++;
    u.value = "";
  }
  // Create an empty <tr> element and add it to the 1st position of the table:
  var row = table.insertRow(count3);
  row.style.setProperty("-webkit-animation", "fadeIn 1s");
  row.style.setProperty("animation", "fadeIn 1s");
  if(count3==1||count3==3)
  {
    row.style.backgroundColor="#edf0f2";
  }
  else
  {
    row.style.backgroundColor="#ccdfe8";
  }
  // Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  var cell3 = row.insertCell(2);
  cell1.style.whiteSpace='nowrap';
  cell1.style.padding="10px 10px 10px 10px";
  cell2.style.whiteSpace='nowrap';
  cell2.style.padding="10px 10px 10px 10px";
  cell2.style.textOverflow="ellipsis";
  cell2.style.overflow="hidden";
  cell2.style.maxWidth="1px";
  cell3.style.whiteSpace='nowrap';
  cell3.style.padding="10px 10px 10px 10px";
  // Add some text to the new cells:
  cell1.innerHTML = count3;
  cell2.innerHTML = uni;
  cell3.innerHTML = "Delete";
  cell3.style.cursor = "pointer";
  cell3.style.color="#004080";
  cell3.style.textDecoration = "underline";
  cell3.addEventListener("click", function(){
      var myrow =this.parentNode.rowIndex;
      //myrow.style.setProperty("-webkit-animation", "fadeIn 1s");
      //myrow.style.setProperty("animation", "fadeIn 1s");
      table.deleteRow(myrow);
      table.style.setProperty("-webkit-animation", "fadeIn 1s");
      table.style.setProperty("animation", "fadeIn 1s");
      var l = document.getElementById("url-table").rows.length;
      if(l==1)
      {
        table.deleteRow(0);
        table.style.setProperty("-webkit-animation", "fadeIn 1s");
        table.style.setProperty("animation", "fadeIn 1s");
        count3=0;
      }
      else
      {
      for(var i =1;i<l;i++)
      {
        table.rows[i].cells[0].innerHTML = i;
        count3 = i+1;
        if(i==1||i==3)
        {
          table.rows[i].style.backgroundColor="#edf0f2";
        }
        else
        {
          table.rows[i].style.backgroundColor="#ccdfe8";
        }
        table.rows[i].firstChild.style.borderTopLeftRadius="0px";
        table.rows[i].lastChild.style.borderTopRightRadius="0px";
        table.rows[i].firstChild.style.borderBottomLeftRadius="0px";
        table.rows[i].lastChild.style.borderBottomRightRadius="0px";
      }
    }
    table.rows[0].firstChild.style.borderTopLeftRadius="10px";
    table.rows[0].lastChild.style.borderTopRightRadius="10px";
    table.rows[l-1].firstChild.style.borderBottomLeftRadius="10px";
    table.rows[l-1].lastChild.style.borderBottomRightRadius="10px";


    }  , false);
    
  count3++;
  u.value = "";
  var l = document.getElementById("url-table").rows.length;
  for(var t=0;t<l;t++)
  {
    table.rows[t].firstChild.style.borderTopLeftRadius="0px";
    table.rows[t].lastChild.style.borderTopRightRadius="0px";
    table.rows[t].firstChild.style.borderBottomLeftRadius="0px";
    table.rows[t].lastChild.style.borderBottomRightRadius="0px";
  }
  table.rows[0].firstChild.style.borderTopLeftRadius="10px";
  table.rows[0].lastChild.style.borderTopRightRadius="10px";
  table.rows[l-1].firstChild.style.borderBottomLeftRadius="10px";
  table.rows[l-1].lastChild.style.borderBottomRightRadius="10px";
}
else{
    alert("Maximum 4 universities allowed");
    document.getElementById('urlBar').value= "";
}
 }
else
{
  alert("Invalid url, Please re-enter");
  document.getElementById('urlBar').value= "";
}
}

function hideprogbar()
{
document.getElementById('hideprogress').style.display='none';
document.getElementById('homeHeading').innerHTML = "Results";
document.getElementById('hideresults').style.display = 'inline-block';
document.getElementById('mybackbutton').innerHTML= "Back";

calculateRanking();
}



function displayChart(z,c)
{
$('#chartContainer').empty(); 
var r=z-3;
if(c == "Total Faculty")
{
  
    var a1 = parseInt(totalfaculty[r][10][0],10);
    var a2 = parseInt(totalfaculty[r][10][1],10);
    var a3 = parseInt(totalfaculty[r][10][2],10);
    var a4 = parseInt(totalfaculty[r][10][3],10);
    var a5 = parseInt(totalfaculty[r][10][4],10);
    var a6 = parseInt(totalfaculty[r][10][5],10);
    var a7 = parseInt(totalfaculty[r][10][6],10);
    var a8 = parseInt(totalfaculty[r][10][7],10);
    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
     title:{
      text: "Faculty Details"
    },
    legend: {
      maxWidth: 350,
      itemWidth: 120
    },
    data: [
    {
      type: "pie",
      showInLegend: true,
      legendText: "{indexLabel}",
      dataPoints: [

      ]
    }

    ]
  });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: a1 ,indexLabel: 'Associate faculty'});
    chart.options.data[0].dataPoints.push({ y: a2 ,indexLabel: 'Assistant faculty'});
    chart.options.data[0].dataPoints.push({ y: a3 ,indexLabel: 'Visiting faculty'});
    chart.options.data[0].dataPoints.push({ y: a4 ,indexLabel: 'Lecturer'});
    chart.options.data[0].dataPoints.push({ y: a5 ,indexLabel: 'Instructor'});
    chart.options.data[0].dataPoints.push({ y: a6 ,indexLabel: 'Lab Engineer'});
    chart.options.data[0].dataPoints.push({ y: a7 ,indexLabel: 'Research Associate'});
    chart.options.data[0].dataPoints.push({ y: a8 ,indexLabel: 'Professor'});
    //chart.options.data[0].dataPoints.push({ y: a9 ,indexLabel: 'Adjunct Professor'});
    chart.render();

  }
  else if(c == "Total PhD professors")
  {
    var tf = parseInt(totalfaculty[r][0],10);
    var phdfac = parseInt(totalfaculty[r][1],10);
    var n = tf-phdfac;
    var nonphd = parseInt(n,10);

    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
     title:{
      text: "PhD vs Non PhD"
    },
    legend: {
      maxWidth: 350,
      itemWidth: 120
    },
    data: [
    {
      type: "pie",
      showInLegend: true,
      legendText: "{indexLabel}",
      dataPoints: [
      ]
    }

    ]
  });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: phdfac ,indexLabel: 'PhD faculty'});
    chart.options.data[0].dataPoints.push({ y: nonphd ,indexLabel: 'Non PhD faculty'});
    chart.render();

  }
  else if(c == "Foreign qualified PhD faculty")
  {
    var phdfac = parseInt(totalfaculty[r][1],10);
    var fphd = parseInt(totalfaculty[r][2],10);
    var nf = phdfac-fphd;
    var nonfphd = parseInt(nf,10);


    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
     title:{
      text: "PhD vs Foreign"
    },
    legend: {
      maxWidth: 350,
      itemWidth: 120
    },
    data: [
    {
      type: "pie",
      showInLegend: true,
      legendText: "{indexLabel}",
      dataPoints: [
      ]
    }

    ]
  });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: fphd ,indexLabel: 'Foreign PhD faculty'});
    chart.options.data[0].dataPoints.push({ y: nonfphd ,indexLabel: 'Non Foreign PhD faculty'});
    chart.render();

  }
  else if(c == "Journals")
  {
    var cpapers = totalfaculty[r][5];
    var totalcpapers = parseInt(totalfaculty[r][5][totalfaculty[r][5].length]);
    var cpapersname = [];
    var cpaperscount = [];
    var l =totalfaculty[r][5].length-1;
    for(var y=0;y<l;)
    {
      cpapersname.push(totalfaculty[r][5][y]);
      y++;
      cpaperscount.push(parseInt(totalfaculty[r][5][y]));
      y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.innerHTML="Sno.";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.innerHTML="Faculty Name";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.innerHTML="Count of Papers";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerhtml=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];
    }
  }
  else if(c == "Books published")
  {
    var cpapers = totalfaculty[r][8];
    var totalcpapers = parseInt(totalfaculty[r][8][totalfaculty[r][8].length]);
    var cpapersname = [];
    var cpaperscount = [];
    var l =totalfaculty[r][8].length-1;
    for(var y=0;y<l;)
    {
      cpapersname.push(totalfaculty[r][8][y]);
      y++;
      cpaperscount.push(parseInt(totalfaculty[r][8][y]));
      y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Faculty Name";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.style.textAlign="center";
    cell1.innerHTML="Count of Papers";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerhtml=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];

    }
  }
  else if(c == "Conference papers")
  {
    var cpapers = totalfaculty[r][9];
    var cpapersname = [];
    var cpaperscount = [];
    var l =totalfaculty[r][9].length-1;
    for(var y=0;y<l;)
    {
        cpapersname.push(totalfaculty[r][9][y]);
        y++;
        cpaperscount.push(parseInt(totalfaculty[r][9][y]));
        y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Faculty Name";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.style.textAlign="center";
    cell1.innerHTML="Count of Papers";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerHTML=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];
    }
  }
  else if(c == "Research groups")
  {
    var cpapers = totalfaculty[r][3];
    var cpapersname = [];
    var l =totalfaculty[r][3].length-1;
    for(var y=0;y<l;)
    {
        cpapersname.push(totalfaculty[r][3][y]);
        y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Research Group Name";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      cell1.innerHTML=t+1;
      cell2.innerHTML=cpapersname[t];
    }
  }
}
function displayChart1(z,c)
{ 
  var r=z-3;
  if(c == "Total Faculty")
  {
    var a1 = parseInt(filteredfaculty[r][10][0],10);
    var a2 = parseInt(filteredfaculty[r][10][1],10);
    var a3 = parseInt(filteredfaculty[r][10][2],10);
    var a4 = parseInt(filteredfaculty[r][10][3],10);
    var a5 = parseInt(filteredfaculty[r][10][4],10);
    var a6 = parseInt(filteredfaculty[r][10][5],10);
    var a7 = parseInt(filteredfaculty[r][10][6],10);
    var a8 = parseInt(filteredfaculty[r][10][7],10);
    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title:{
        text: "Faculty Details"
      },
      legend: {
        maxWidth: 350,
        itemWidth: 120
      },
      data: [
      {
        type: "pie",
        showInLegend: true,
        legendText: "{indexLabel}",
        dataPoints: [

        ]
      }

      ]
    });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: a1 ,indexLabel: 'Associate faculty'});
    chart.options.data[0].dataPoints.push({ y: a2 ,indexLabel: 'Assistant faculty'});
    chart.options.data[0].dataPoints.push({ y: a3 ,indexLabel: 'Visiting faculty'});
    chart.options.data[0].dataPoints.push({ y: a4 ,indexLabel: 'Lecturers'});
    chart.options.data[0].dataPoints.push({ y: a5 ,indexLabel: 'Instructors'});
    chart.options.data[0].dataPoints.push({ y: a6 ,indexLabel: 'Lab Engineers'});
    chart.options.data[0].dataPoints.push({ y: a7 ,indexLabel: 'Research Associate'});
    chart.options.data[0].dataPoints.push({ y: a8 ,indexLabel: 'Professor'});
    chart.render();

  }
  else if(c == "Total PhD professors")
  {
    var tf = parseInt(filteredfaculty[r][0],10);
    var phdfac = parseInt(filteredfaculty[r][1],10);
    var n = tf-phdfac;
    var nonphd = parseInt(n,10);

    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title:{
        text: "PhD vs Non PhD"
      },
      legend: {
        maxWidth: 350,
        itemWidth: 120
      },
      data: [
      {
        type: "pie",
        showInLegend: true,
        legendText: "{indexLabel}",
        dataPoints: [
        ]
      }

      ]
    });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: phdfac ,indexLabel: 'PhD faculty'});
    chart.options.data[0].dataPoints.push({ y: nonphd ,indexLabel: 'Non PhD faculty'});
    chart.render();

  }
  else if(c == "Foreign qualified PhD professors")
  {
    var phdfac = parseInt(filteredfaculty[r][1],10);
    var fphd = parseInt(filteredfaculty[r][2],10);
    var nf = phdfac-fphd;
    var nonfphd = parseInt(nf,10);


    $('#myModal').modal('show');
    var chart = new CanvasJS.Chart("chartContainer",
    {
      title:{
        text: "PhD vs Foreign"
      },
      legend: {
        maxWidth: 350,
        itemWidth: 120
      },
      data: [
      {
        type: "pie",
        showInLegend: true,
        legendText: "{indexLabel}",
        dataPoints: [
        ]
      }

      ]
    });
    chart.options.data[0].dataPoints = [];
    chart.options.data[0].dataPoints.push({ y: fphd ,indexLabel: 'Foreign PhD faculty'});
    chart.options.data[0].dataPoints.push({ y: nonfphd ,indexLabel: 'Non Foreign PhD faculty'});
    chart.render();
  }
  else if(c == "Journals")
  {
    var cpapers = filteredfaculty[r][5];
    var totalcpapers = parseInt(filteredfaculty[r][5][filteredfaculty[r][5].length]);
    var cpapersname = [];
    var cpaperscount = [];
    var l =filteredfaculty[r][5].length-1;
    for(var y=0;y<l;)
    {
      cpapersname.push(filteredfaculty[r][5][y]);
      y++;
      cpaperscount.push(parseInt(filteredfaculty[r][5][y]));
      y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.innerHTML="Sno.";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.innerHTML="Faculty Name";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.innerHTML="Count of Papers";
    cell1.style.textAlign="center";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerhtml=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];
    }
  }
  else if(c == "Books published")
  {
    var cpapers = filteredfaculty[r][8];
    var totalcpapers = parseInt(filteredfaculty[r][8][filteredfaculty[r][8].length]);
    var cpapersname = [];
    var cpaperscount = [];
    var l =filteredfaculty[r][8].length-1;
    for(var y=0;y<l;)
    {
      cpapersname.push(filteredfaculty[r][8][y]);
      y++;
      cpaperscount.push(parseInt(filteredfaculty[r][8][y]));
      y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Faculty Name";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.style.textAlign="center";
    cell1.innerHTML="Count of Papers";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerhtml=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];

    }
  }
  else if(c == "Conference papers")
  {
    var cpapers = filteredfaculty[r][9];
    var totalcpapers = parseInt(filteredfaculty[r][9][filteredfaculty[r][9].length]);
    var cpapersname = [];
    var cpaperscount = [];
    var l =filteredfaculty[r][9].length-1;
    for(var y=0;y<l;)
    {
      cpapersname.push(filteredfaculty[r][9][y]);
      y++;
      cpaperscount.push(parseInt(filteredfaculty[r][9][y]));
      y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Faculty Name";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(2);
    cell1.style.textAlign="center";
    cell1.innerHTML="Count of Papers";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l/2;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      var cell3 = row.insertCell(2);
      cell3.style.textAlign="center";
      cell3.style.padding="10px 10px 10px 10px";
      cell1.innerhtml=t+1;
      cell2.innerHTML=cpapersname[t];
      cell3.innerHTML=cpaperscount[t];
    }
  }
  else if(c == "Research groups")
  {
    var cpapers = filteredfaculty[r][3];
    var cpapersname = [];
    var l =filteredfaculty[r][3].length-1;
    for(var y=0;y<l;)
    {
        cpapersname.push(filteredfaculty[r][3][y]);
        y++;
    }
    $('#myModal').modal('show');
    var mytable = document.createElement('table');
    mytable.style.display='inline-block';
    mytable.style.width="90%";
    mytable.style.overflow="auto";
    mytable.style.height="400px";
    var cbh = document.getElementById("chartContainer");
    cbh.appendChild(mytable);
    var row =mytable.insertRow(0);
    row.style.color="orange";
    row.style.fontSize="20px";
    row.style.backgroundColor="#5b6472";
    var cell1 = row.insertCell(0);
    cell1.style.textAlign="center";
    cell1.innerHTML="Sno.";
    cell1.style.padding="10px 10px 10px 10px";
    var cell1 = row.insertCell(1);
    cell1.style.textAlign="center";
    cell1.innerHTML="Research Group Name";
    cell1.style.padding="10px 10px 10px 10px";
    for(var t=0;t<l;t++)
    {
      var row = mytable.insertRow(t+1);
      if(t%2==0)
      {
        row.style.backgroundColor="#edf0f2";
      }
      else
      {
        row.style.backgroundColor="#ccdfe8;";
      }
      var cell1 = row.insertCell(0);
      cell1.style.textAlign="center";
      cell1.style.padding="10px 10px 10px 10px";
      var cell2 = row.insertCell(1);
      cell2.style.textAlign="center";
      cell2.style.padding="10px 10px 10px 10px";
      cell1.innerHTML=t+1;
      cell2.innerHTML=cpapersname[t];
    }
  }
}



function loadDoc(a,b) {
  var arr1 = JSON.stringify(b);
  var arr2 = JSON.stringify(a);
var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {

  if (this.readyState == 4 && this.status == 200) {
    helo=this.responseText;

    var myJsonString = JSON.parse(helo);
    totalfaculty.push(myJsonString);
        changeimage(counter);
        counter++;
        if(counter<universities.length)
        {
          asad(counter);  
        }
        if(counter==universities.length&&resultscheck==true)
        {
          hideprogbar();
        }

      }
    };
    xhttp.open("GET", "/check?first="+arr1+"&second="+arr2, true);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send();
  }
  function hideuniscrit()
  {
   document.getElementById('checkboxes').style.display='none';
//document.getElementById('ranking_table').style.display='inline-block';
document.getElementById('table1').style.display='inline-block';
calculateRanking();
}



function displayuniversities()
{
//document.getElementById('ranking_table').style.display='none';
document.getElementById('table1').style.display='none';
var cbh = document.getElementById('checkboxes');
cbh.style.display='inline-block';
while (cbh.hasChildNodes())
{
  cbh.removeChild(cbh.lastChild);
}
var br = document.createElement('br');
cbh.appendChild(br);
var lab = document.createElement('h3');
lab.innerHTML = "Please filter universities";
cbh.appendChild(lab);

for (var i = 0; i < universities.length; i++)
{
  var val = i;
  var cap = "       " + universities[i];
  var cb = document.createElement('input');
  cb.type = 'checkbox';
  cbh.appendChild(cb);
  cb.name = "unicheck";
  cb.value = cap;
  cbh.appendChild(document.createTextNode(cap));
  var br = document.createElement('br');
  cbh.appendChild(br);
}
var br = document.createElement('br');
cbh.appendChild(br);


var lab = document.createElement('h3');
lab.innerHTML = "Please filter criteria"
cbh.appendChild(lab);

for (var j = 0; j < criteriasinfo.length; j++)
{
  var val = j;
  var cap =criteriasinfo[j];
  var cb = document.createElement('input');
  cb.type = 'checkbox';
  cbh.appendChild(cb);
  cb.name = "cricheck";
  cb.value = cap;
  cbh.appendChild(document.createTextNode(cap));
  var br = document.createElement('br');
  cbh.appendChild(br);
}

var br = document.createElement('br');
cbh.appendChild(br);

var button = document.createElement('button');
button.innerHTML = "Show Filtered Results";
button.style.cursor = 'pointer';
button.setAttribute("class", "btn btn-primary btn-xl");
button.setAttribute("id","filterbutton"); 
cbh.appendChild(button);
button.addEventListener ("click", filteredresults );
}



function url_exist(){//se passar a URL existe
url = document.getElementById('urlBar').value;
var re = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
if (!re.test(url)) 
{ 
 return false;
}
else
{
 return true;
}
}
function validateUrl(value) {
return /^(?:(?:(?:https?|ftp):)?\/\/)(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:[/?#]\S*)?$/i.test(value);
}
















////////////////////////////////////////////////////////////////////////



$(document).ready(function() {
    $('#contact_form').bootstrapValidator({
        // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            first_name: {
                validators: {
                        stringLength: {
                        min: 2,
                    },
                        notEmpty: {
                        message: 'Please supply your first name'
                    }
                }
            },
             last_name: {
                validators: {
                     stringLength: {
                        min: 2,
                    },
                    notEmpty: {
                        message: 'Please supply your last name'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'Please supply your email address'
                    },
                    emailAddress: {
                        message: 'Please supply a valid email address'
                    }
                }
            },
            phone: {
                validators: {
                    notEmpty: {
                        message: 'Please supply your phone number'
                    },
                    phone: {
                        country: 'US',
                        message: 'Please supply a vaild phone number with area code'
                    }
                }
            },
            address: {
                validators: {
                     stringLength: {
                        min: 8,
                    },
                    notEmpty: {
                        message: 'Please supply your street address'
                    }
                }
            },
            city: {
                validators: {
                     stringLength: {
                        min: 4,
                    },
                    notEmpty: {
                        message: 'Please supply your city'
                    }
                }
            },
            state: {
                validators: {
                    notEmpty: {
                        message: 'Please select your state'
                    }
                }
            },
            zip: {
                validators: {
                    notEmpty: {
                        message: 'Please supply your zip code'
                    },
                    zipCode: {
                        country: 'US',
                        message: 'Please supply a vaild zip code'
                    }
                }
            },
            comment: {
                validators: {
                      stringLength: {
                        min: 10,
                        max: 200,
                        message:'Please enter at least 10 characters and no more than 200'
                    },
                    notEmpty: {
                        message: 'Please supply a description of your project'
                    }
                    }
                }
            }
        })
        .on('success.form.bv', function(e) {
            $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
                $('#contact_form').data('bootstrapValidator').resetForm();

            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post($form.attr('action'), $form.serialize(), function(result) {
                console.log(result);
            }, 'json');
        });
});



////pagination
$( document ).ready(function() {
  
    var paginationHandler = function(){
    // store pagination container so we only select it once
    var $paginationContainer = $(".pagination-container"),
        $pagination = $paginationContainer.find('.pagination ul');
    // click event
    $pagination.find("li a").on('click.pageChange',function(e){
        e.preventDefault();
        // get parent li's data-page attribute and current page
    var parentLiPage = $(this).parent('li').data("page"),
    currentPage = parseInt( $(".pagination-container div[data-page]:visible").data('page') ),
    numPages = $paginationContainer.find("div[data-page]").length;
    // make sure they aren't clicking the current page
    if ( parseInt(parentLiPage) !== parseInt(currentPage) ) {
    // hide the current page
    $paginationContainer.find("div[data-page]:visible").hide();
    if ( parentLiPage === '+' ) {
                // next page
        $paginationContainer.find("div[data-page="+( currentPage+1>numPages ? numPages : currentPage+1 )+"]").show();
    } else if ( parentLiPage === '-' ) {
                // previous page
        $paginationContainer.find("div[data-page="+( currentPage-1<1 ? 1 : currentPage-1 )+"]").show();
    } else {
        // specific page
        $paginationContainer.find("div[data-page="+parseInt(parentLiPage)+"]").show();
            }
        }
    });
};
$(document).ready( paginationHandler );
});



function cb1()
{
  var a = document.getElementById("s1");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb2()
{
  var a = document.getElementById("s2");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb3()
{
  var a = document.getElementById("s3");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb4()
{
  var a = document.getElementById("s4");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb5()
{
  var a = document.getElementById("s5");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb6()
{
  var a = document.getElementById("s6");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb7()
{
  var a = document.getElementById("s7");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb8()
{
  var a = document.getElementById("s8");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb9()
{
  var a = document.getElementById("s9");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}
function cb10()
{
  var a = document.getElementById("s10");
  a.disabled = !a.disabled;
  if(a.disabled)
  {
    a.style.opacity=0.5;
    a.style.cursor="not-allowed";
  }
  else{
    a.style.opacity=1;
    a.style.cursor="pointer";
  }
}

function progressfunction()
{
  document.getElementById('getuninames').style.display='none';
  document.getElementById('hideprogress').style.display='inline-block';
  var table = document.getElementById('progress-table');
  table.style.setProperty("-webkit-animation", "fadeIn 1s");
  table.style.setProperty("animation", "fadeIn 1s");
  table.innerHTML="";

  var row = table.insertRow(0);  
  
  var cell1 = row.insertCell(0);
  var cell2 = row.insertCell(1);
  cell1.innerHTML="University";
  cell1.style.textAlign="center";
  cell1.style.padding="10px 10px 10px 10px";
  cell2.innerHTML="Progress";
  cell2.style.textAlign="center";
  cell2.style.padding="10px 10px 10px 10px";
  cell1.style.textDecoration="underline";
  cell2.style.textDecoration="underline";
  row.style.color="orange";
  row.style.fontSize="20px";
  row.style.backgroundColor="#5b6472";
  row = table.insertRow(1);
  row.style.color="orange";
  row.style.fontSize="20px";
  row.style.backgroundColor="#5b6472";
  for(var i=0;i<universities.length;i++)
  {
    var row = table.insertRow(i+1);
    var cell1 = row.insertCell(0);
    cell1.style.padding="10px 10px 10px 10px";
    cell1.innerHTML = uni_name_string[i];
    var cell2 = row.insertCell(1);
    cell2.style.padding="10px 10px 10px 10px";
    cell2.style.textAlign="center";
    cell2.innerHTML="<img src='/processing.gif' style='width:16px;height:16px;'/>";
    if(i==0||i==2)
    {
      row.style.backgroundColor="#edf0f2";
    }
    else
    {
      row.style.backgroundColor="#ccdfe8";
    }
    
  }
  var l = document.getElementById("progress-table").rows.length;
  table.rows[0].firstChild.style.borderTopLeftRadius="10px";
  table.rows[0].lastChild.style.borderTopRightRadius="10px";
  table.rows[l-1].firstChild.style.borderBottomLeftRadius="10px";
  table.rows[l-1].lastChild.style.borderBottomRightRadius="10px";
  document.getElementById('homeHeading').innerHTML = "Calculating Results...";
}

function changeimage(i)
{
  var table = document.getElementById('progress-table');
  table.rows[i+1].cells[1].innerHTML="<img src='/green.png' style='width:16px;height:16px;-webkit-animation: fadeIn 1s;animation: fadeIn 1s;'/>";
}
/*
document.getElementById("urlbar")
.addEventListener("keyup", function(event) {
event.preventDefault();
if (event.keyCode === 13) {
    document.getElementById("check1").click();
}
});*/




$(document).ready(function()
{
    // codes works on all bootstrap modal windows in application
    $('#myModal').on('hidden.bs.modal', function(e)
    { 
      $('#chartContainer').empty();
    }) ;

});

function substrmatch(s1,s2)
{
  var index=0;
  var max=0;
	for(var i=0;i<s1.length;i++)
	{
		if(s1[i]==s2[0])
		{
			var k=i;
      var l=0;
			while(s1[k]==s2[l])
			{
				k++;
				l++;
        index++;
			}
      if(index>max)
      {
        max = index;
      }
			index=0;
		}
  }
  return max;
}
function getprogramscount(ind)
{
  var programs=["lahore.comsats.edu.pk/",
    "39",
    "islamabad.comsats.edu.pk/",
    "60",
    "ciit-atd.edu.pk/",
    "41",
    "wah.comsats.edu.pk/",
    "18",
    "attock.comsats.edu.pk/",
    "18",
    "sahiwal.comsats.edu.pk/",
    "16",
    "vehari.comsats.edu.pk/",
    "13",
    "vcomsats.edu.pk/",
    "12",
    "fuuast.edu.pk/",
    "86",
    "bahria.edu.pk/buic/",
    "42",
    "bahria.edu.pk/bukc/",
    "19",
    "bahria.edu.pk/bulc/",
    "6",
    "au.edu.pk/Au_Web/Home.aspx",
    "31",
    "aumc.edu.pk/",
    "8",
    "kiu.edu.pk/",
    "21",
    "uet.edu.pk/",
    "93",
    "uet.edu.pk/campus?RID=info&campus_id=2",
    "7",
    "uet.edu.pk/campus?RID=info&campus_id=4",
    "4",
    "uet.edu.pk/campus?RID=info&campus_id=3",
    "4",
    "uet.edu.pk/campus?RID=info&campus_id=5",
    "4",
    "web.uettaxila.edu.pk/uet/index.asp",
    "59",
    "pu.edu.pk",
    "419",
    "bzu.edu.pk/",
    "208",
    "iub.edu.pk/",
    "20",
    "uaf.edu.pk/",
    "123",
    "uog.edu.pk/main.php",
    "32",
    "usindh.edu.pk",
    "55",
    "usindh.edu.pk/our-campuses/larkana-campus",
    "12",
    "usindh.edu.pk/our-campuses/sindh-university-thatta-campus/",
    "4",
    "usindh.edu.pk/our-campuses/mohtarma-benazir-bhutto-shaheed-campus-dadu/",
    "8",
    "usindh.edu.pk/our-campuses/sindh-university-mirpurkhas-campus",
    "1",
    "muet.edu.pk/",
    "36",
    "riphah.edu.pk/",
    "82",
    "lahore.riphah.edu.pk/",
    "38",
    "hup.edu.pk/",
    "52",
    "lums.edu.pk/",
    "34",
    "cs.qau.edu.pk/",
    "5",
    "iiu.edu.pk/default.htm",
    "85",
    "uok.edu.pk/",
    "212",
    "uom.edu.pk/beta/",
    "47",
    "ccsis.iobm.edu.pk/",
    "site down",
    "ucp.edu.pk/",
    "51",
    "uow.edu.pk/Default.aspx",
    "40",
    "sbbu.edu.pk/",
    "0",
    "uol.edu.pk/",
    "10",
    "lcwu.edu.pk/",
    "58",
    "suit.edu.pk/",
    "0",
    "nu.edu.pk/",
    "22",
    "peshawar.abasyn.edu.pk/index.php#",
    "34",
    "hamdard.edu.pk/",
    "82",
    "umt.edu.pk/",
    "154",
    "quest.edu.pk/",
    "19",
    "salu.edu.pk/",
    "0"];
    var temp=0;
    var maxy=0;
    var index=0;
  for(var i=0;i<programs.length;i=i+2)
  {

    temp = substrmatch(universities[ind],programs[i]);
    if(maxy<temp)
    {
      maxy=temp;
      index=i+1;
    }
  }
  totalfaculty[ind][4]=programs[index];
}