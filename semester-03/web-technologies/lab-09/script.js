const button = document.getElementById('theme');
button.addEventListener('click', () => {
    const main = document.querySelector('main');
    const theme = main.dataset.bsTheme === 'light' ? 'dark' : 'light';
    main.dataset.bsTheme = theme;
    document.documentElement.dataset.bsTheme = theme;
});
