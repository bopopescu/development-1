// PUT THE URL'S OF YOUR IMAGES INTO THIS ARRAY...
var Slides = new Array('buttons/button square ltblue.gif','buttons/button square dkblue.gif','buttons/button square ltred.gif','buttons/button square dkred.gif','buttons/button square ltgreen.gif','buttons/button square dkgreen.gif','buttons/button square ltyellow.gif','buttons/button square dkyellow.gif','buttons/button square ltbrown.gif','buttons/button square dkbrown.gif','buttons/button square gray.gif','buttons/button round ltblue.gif','buttons/button round dkblue.gif','buttons/button round ltred.gif','buttons/button round dkred.gif','buttons/button round ltgreen.gif','buttons/button round dkgreen.gif','buttons/button round ltyellow.gif','buttons/button round dkyellow.gif','buttons/button round ltbrown.gif','buttons/button round dkbrown.gif','buttons/button round gray.gif','buttons/button bar ltblue.gif','buttons/button bar dkblue.gif','buttons/button bar ltred.gif','buttons/button bar dkred.gif','buttons/button bar ltgreen.gif','buttons/button bar dkgreen.gif','buttons/button bar ltyellow.gif','buttons/button bar dkyellow.gif','buttons/button bar ltbrown.gif','buttons/button bar dkbrown.gif','buttons/button bar gray.gif','buttons/TextLink.gif');

// DO NOT EDIT BELOW THIS LINE!
function CacheImage(ImageSource) { // TURNS THE STRING INTO AN IMAGE OBJECT
   var ImageObject = new Image();
   ImageObject.src = ImageSource;
   return ImageObject;
}

function ShowSlide(Direction) {
   if (SlideReady) {
      NextSlide = CurrentSlide + Direction;
      // THIS WILL DISABLE THE BUTTONS (IE-ONLY)
      document.SlideShow.Previous.disabled = (NextSlide == 0);
      document.SlideShow.Next.disabled = (NextSlide == 
(Slides.length-1));    
 if ((NextSlide >= 0) && (NextSlide < Slides.length)) {
            document.images['Screen'].src = Slides[NextSlide].src;
            CurrentSlide = NextSlide++;
            Message = 'Button ' + (CurrentSlide+1) + ' of ' + 
Slides.length;
            self.defaultStatus = Message;
            if (Direction == 1) CacheNextSlide();
      }
      return true;
   }
}

function Download() {
   if (Slides[NextSlide].complete) {
      SlideReady = true;
      self.defaultStatus = Message;
   }
   else setTimeout("Download()", 100); // CHECKS DOWNLOAD STATUS EVERY 100 MS
   return true;
}

function CacheNextSlide() {
   if ((NextSlide < Slides.length) && (typeof Slides[NextSlide] == 
'string'))
{ // ONLY CACHES THE IMAGES ONCE
      SlideReady = false;
      self.defaultStatus = 'Downloading next picture...';
      Slides[NextSlide] = CacheImage(Slides[NextSlide]);
      Download();
   }
   return true;
}

function StartSlideShow() {
   CurrentSlide = -1;
   Slides[0] = CacheImage(Slides[0]);
   SlideReady = true;
   ShowSlide(1);
}