function makeImpactGuide(prompts, category, themeName, gameTitle, age, time, quote, source, gameAbout, themeAbout, whyUse)
{
	var doc = new jsPDF();
	doc.setFontSize(40);
doc.text(35, 25, "Paranyan loves jsPDF");
}


$(function () {
    var doc = new jsPDF();
    var specialElementHandlers = {
        'body': function (element, renderer) { 
            return true;
        }};
    $('#save').click(function () {
        doc.fromHTML($('#pdf').html(), 15, 35, {
            'width': 170,
                'elementHandlers': specialElementHandlers
        });
        doc.save('sample.pdf');
    });
});
