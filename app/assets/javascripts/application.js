var COLORS = [
  '#F00', '#0F0', '#00F', '#FF0', '#0FF',
  '#F0F', '#C00', '#0C0', '#00C'
];

$(document).ready(function() {
  var bins = JSON.parse(document.getElementById('bins').value);

  if (bins) {
    for (var x = 0; x < bins.length; x++) {
      var canvas = document.createElement('canvas');

      var width = document.createAttribute('width');
      width.value = bins[x].width;
      canvas.setAttributeNode(width);

      var height = document.createAttribute('height');
      height.value = bins[x].height;
      canvas.setAttributeNode(height);

      document.getElementById('canvas').appendChild(canvas);

      var ctx = canvas.getContext('2d');
      var items = bins[x].items;
      var largerEnd = 0;

      for (var y = 0; y < items.length; y++) {
        var detailsContainer = document.createElement('div');

        var nameP = document.createElement('p');
        nameP.appendChild(document.createTextNode(items[y].name));
        detailsContainer.appendChild(nameP);

        var binP = document.createElement('p');
        binP.appendChild(document.createTextNode((x + 1) + '° bin'));
        detailsContainer.appendChild(binP);

        var xP = document.createElement('p');
        xP.appendChild(document.createTextNode('x: ' + items[y].x));
        detailsContainer.appendChild(xP);

        var yP = document.createElement('p');
        yP.appendChild(document.createTextNode('y: ' + items[y].y));
        detailsContainer.appendChild(yP);

        var widthP = document.createElement('p');
        widthP.appendChild(document.createTextNode('width: ' + (items[y].width - 3)));
        detailsContainer.appendChild(widthP);

        var heightP = document.createElement('p');
        heightP.appendChild(
          document.createTextNode('height: ' + (items[y].height - 3))
        );
        detailsContainer.appendChild(heightP);

        if (items[y].rotated) {
          var rotatedP = document.createElement('p');
          rotatedP.appendChild(
            document.createTextNode('Rotado')
          );

          var classAttr = document.createAttribute('class');
          classAttr.value = 'rotated';
          rotatedP.setAttributeNode(classAttr);

          detailsContainer.appendChild(rotatedP);
        }

        document.getElementById('details').appendChild(detailsContainer);

        ctx.fillStyle = COLORS[y % COLORS.length];
        ctx.fillRect(
          items[y].x, items[y].y, items[y].width, items[y].height
        );

        if (items[y].y + items[y].height > largerEnd) {
          largerEnd = items[y].y + items[y].height;
        }
      }

      var maxHeightH2 = document.createElement('h2');
      document.getElementById('max-heights').appendChild(maxHeightH2);
      maxHeightH2.innerHTML += 'Alto max ' + (x + 1) + '° placa: ' + largerEnd;
    }
  }

});
