new Vue({
    el: '#app',
    data: {},
    methods: {
      hideElements() {$('.back').hide()},
      showBody() {$('.back').fadeIn(0).addClass('fadeIn')},
      hideBody() {$('.back').addClass('fadeOut'); setTimeout(() => { $('.back').hide().removeClass('fadeOut'); }, 500)},
      sendAction(action) { $.post('https://cT-SimplePauseMenu/SendAction', JSON.stringify({ action })) },
    },
    mounted() {
      var appendSound = new Audio('https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/gta4.wav');
      var click = new Audio('https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/click.wav');
      var hover = new Audio('https://r2.fivemanage.com/QbMW9SvJrh8gWirlVt5Ee/hover.wav');

      appendSound.volume = 0.35;
      click.volume = 0.75;
      hover.volume = 0.75;

      this.hideElements();

      window.addEventListener('message', (event) => {
        const {action} = event.data;
        if (action === 'openEsc') {
          this.showBody();
          appendSound.currentTime = 0; 
          appendSound.play();
        } else if (action === 'closeEsc') {
          this.hideBody();
        }
      });

      $(document).on('click', '#continue', () => { this.sendAction('exit') });
      $(document).on('click', '#radar', () => { this.sendAction('map'); this.sendAction('exit') });
      $(document).on('click', '#settings', () => { this.sendAction('settings'); this.sendAction('exit') });
      $(document).on('click', '#exit', () => { window.invokeNative('quit', 'you left the game'); });
      $(document).on('click', '#continue, #radar, #settings, #exit', function() {click.currentTime = 0; click.play()});
      $(document).on('mouseenter', '#continue, #radar, #settings, #exit', function() {hover.currentTime = 0; hover.play()});
      document.onkeydown = ({ key }) => key === 'Escape' && this.sendAction('exit')
    },
});