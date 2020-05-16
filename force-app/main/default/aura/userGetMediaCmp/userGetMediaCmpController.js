({
    doInit: function (component, event, helper) {

        var width = 400; // scale the photo width to this
        var height = 0; // computed based on the input stream

        var streaming = false;
        var video = null;
        var canvas = null;
        var photo = null;
        var startbutton = null;
        video = document.getElementById('video');
        canvas = document.getElementById('canvas');
        photo = document.getElementById('photo');
        startbutton = document.getElementById('startbutton');
        var clearbutton = document.getElementById('clearbutton');

        navigator.mediaDevices.getUserMedia({video: true, audio: false})
            .then(function(stream) {
                video.srcObject = stream;
                video.play();
            })
            .catch(function(err) {
                console.log("An error occurred: " + err);
            });

        video.addEventListener('canplay', function(ev){
            if (!streaming) {
                height = video.videoHeight / (video.videoWidth/width);

                // Firefox currently has a bug where the height can't be read from
                // the video, so make assumptions if this happens.

                if (isNaN(height)) {
                    height = width / (4/3);
                }

                video.setAttribute('width', width);
                video.setAttribute('height', height);
                canvas.setAttribute('width', width);
                canvas.setAttribute('height', height);
                streaming = true;
            }
        }, false);

        startbutton.addEventListener('click', function(ev){
            takepicture();
        }, false);

        clearbutton.addEventListener('click', function(ev){
            clearphoto();
        }, false);
        clearphoto();

        function clearphoto() {
            var context = canvas.getContext('2d');
            context.fillStyle = "#AAA";
            context.fillRect(0, 0, canvas.width, canvas.height);

            var data = canvas.toDataURL('image/png');
            photo.setAttribute('src', data);
        }

        function takepicture() {
            var context = canvas.getContext('2d');
            if (width && height) {
                canvas.width = width;
                canvas.height = height;
                context.drawImage(video, 0, 0, width, height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
                console.log('click data ',data);
            } else {
                clearphoto();
            }
        }
    },

    afterScriptLoaded: function (c, e, h) {
        console.log('script loaded');
        var canvas1 = document.getElementById('canvas');
        var canvas = window._canvas = new fabric.Canvas('c');
        fabric.Object.prototype.originX = fabric.Object.prototype.originY = 'center';
        canvas.isDrawingMode = true;
        canvas.freeDrawingBrush = new fabric.PencilBrush(canvas);
        canvas.freeDrawingBrush.color = 'black';
        canvas.freeDrawingBrush.width = 5;
        //canvas.add(canvas1.toDataURL('image/png'));
        canvas.renderAll();
        /*(function() {
            window.addEventListener('load', function() {
                var canvas = this.__canvas || this.canvas,
                    canvases = this.__canvases || this.canvases;
                canvas && canvas.calcOffset && canvas.calcOffset();

                if (canvases && canvases.length) {
                    for (var i = 0, len = canvases.length; i < len; i++) {
                        canvases[i].calcOffset();
                    }
                }
            });
        })();

        (function () {
            var $ = function (id) {
                return document.getElementById(id)
            };
            var canvas = this.__canvas = new fabric.Canvas('c', {
                isDrawingMode: true
            });
            console.log('canvas ::::', canvas);
            fabric.Object.prototype.transparentCorners = true;
            var drawingModeEl = $('drawing-mode'),
                drawingOptionsEl = $('drawing-mode-options'),
                drawingColorEl = $('drawing-color'),
                drawingShadowColorEl = $('drawing-shadow-color'),
                drawingLineWidthEl = $('drawing-line-width'),
                drawingShadowWidth = $('drawing-shadow-width'),
                drawingShadowOffset = $('drawing-shadow-offset'),
                clearEl = $('clear-canvas');
            console.log('drawingModeEl ::::', drawingModeEl);
            console.log('clearEl ::::', clearEl);

            clearEl.onclick = function () {
                canvas.clear()
            };

            drawingModeEl.onclick = function () {
                canvas.isDrawingMode = !canvas.isDrawingMode;
                if (canvas.isDrawingMode) {
                    drawingModeEl.innerHTML = 'Cancel drawing mode';
                    drawingOptionsEl.style.display = '';
                } else {
                    drawingModeEl.innerHTML = 'Enter drawing mode';
                    drawingOptionsEl.style.display = 'none';
                }
            };

            if (fabric.PatternBrush) {
                var vLinePatternBrush = new fabric.PatternBrush(canvas);
                vLinePatternBrush.getPatternSrc = function () {

                    var patternCanvas = fabric.document.createElement('canvas');
                    patternCanvas.width = patternCanvas.height = 10;
                    var ctx = patternCanvas.getContext('2d');

                    ctx.strokeStyle = this.color;
                    ctx.lineWidth = 5;
                    ctx.beginPath();
                    ctx.moveTo(0, 5);
                    ctx.lineTo(10, 5);
                    ctx.closePath();
                    ctx.stroke();

                    return patternCanvas;
                };

                var hLinePatternBrush = new fabric.PatternBrush(canvas);
                hLinePatternBrush.getPatternSrc = function () {

                    var patternCanvas = fabric.document.createElement('canvas');
                    patternCanvas.width = patternCanvas.height = 10;
                    var ctx = patternCanvas.getContext('2d');

                    ctx.strokeStyle = this.color;
                    ctx.lineWidth = 5;
                    ctx.beginPath();
                    ctx.moveTo(5, 0);
                    ctx.lineTo(5, 10);
                    ctx.closePath();
                    ctx.stroke();

                    return patternCanvas;
                };

                var squarePatternBrush = new fabric.PatternBrush(canvas);
                squarePatternBrush.getPatternSrc = function () {

                    var squareWidth = 10, squareDistance = 2;

                    var patternCanvas = fabric.document.createElement('canvas');
                    patternCanvas.width = patternCanvas.height = squareWidth + squareDistance;
                    var ctx = patternCanvas.getContext('2d');

                    ctx.fillStyle = this.color;
                    ctx.fillRect(0, 0, squareWidth, squareWidth);

                    return patternCanvas;
                };

                var diamondPatternBrush = new fabric.PatternBrush(canvas);
                diamondPatternBrush.getPatternSrc = function () {

                    var squareWidth = 10, squareDistance = 5;
                    var patternCanvas = fabric.document.createElement('canvas');
                    var rect = new fabric.Rect({
                        width: squareWidth,
                        height: squareWidth,
                        angle: 45,
                        fill: this.color
                    });

                    var canvasWidth = rect.getBoundingRect().width;

                    patternCanvas.width = patternCanvas.height = canvasWidth + squareDistance;
                    rect.set({left: canvasWidth / 2, top: canvasWidth / 2});

                    var ctx = patternCanvas.getContext('2d');
                    rect.render(ctx);

                    return patternCanvas;
                };

                var img = new Image();
                img.src = '../assets/honey_im_subtle.png';

                var texturePatternBrush = new fabric.PatternBrush(canvas);
                texturePatternBrush.source = img;
            }

            $('drawing-mode-selector').onchange = function () {

                if (this.value === 'hline') {
                    canvas.freeDrawingBrush = vLinePatternBrush;
                } else if (this.value === 'vline') {
                    canvas.freeDrawingBrush = hLinePatternBrush;
                } else if (this.value === 'square') {
                    canvas.freeDrawingBrush = squarePatternBrush;
                } else if (this.value === 'diamond') {
                    canvas.freeDrawingBrush = diamondPatternBrush;
                } else if (this.value === 'texture') {
                    canvas.freeDrawingBrush = texturePatternBrush;
                } else {
                    canvas.freeDrawingBrush = new fabric[this.value + 'Brush'](canvas);
                }

                if (canvas.freeDrawingBrush) {
                    canvas.freeDrawingBrush.color = drawingColorEl.value;
                    canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
                    canvas.freeDrawingBrush.shadow = new fabric.Shadow({
                        blur: parseInt(drawingShadowWidth.value, 10) || 0,
                        offsetX: 0,
                        offsetY: 0,
                        affectStroke: true,
                        color: drawingShadowColorEl.value,
                    });
                }
            };

            drawingColorEl.onchange = function () {
                canvas.freeDrawingBrush.color = this.value;
            };
            drawingShadowColorEl.onchange = function () {
                canvas.freeDrawingBrush.shadow.color = this.value;
            };
            drawingLineWidthEl.onchange = function () {
                canvas.freeDrawingBrush.width = parseInt(this.value, 10) || 1;
                this.previousSibling.innerHTML = this.value;
            };
            drawingShadowWidth.onchange = function () {
                canvas.freeDrawingBrush.shadow.blur = parseInt(this.value, 10) || 0;
                this.previousSibling.innerHTML = this.value;
            };
            drawingShadowOffset.onchange = function () {
                canvas.freeDrawingBrush.shadow.offsetX = parseInt(this.value, 10) || 0;
                canvas.freeDrawingBrush.shadow.offsetY = parseInt(this.value, 10) || 0;
                this.previousSibling.innerHTML = this.value;
            };

            if (canvas.freeDrawingBrush) {
                canvas.freeDrawingBrush.color = drawingColorEl.value;
                canvas.freeDrawingBrush.width = parseInt(drawingLineWidthEl.value, 10) || 1;
                canvas.freeDrawingBrush.shadow = new fabric.Shadow({
                    blur: parseInt(drawingShadowWidth.value, 10) || 0,
                    offsetX: 0,
                    offsetY: 0,
                    affectStroke: true,
                    color: drawingShadowColorEl.value,
                });
            }
        })();*/
    }
})