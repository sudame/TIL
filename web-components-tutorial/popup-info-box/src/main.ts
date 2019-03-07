class PopUpInfo extends HTMLElement {
  constructor() {
    super();
    const shadow: ShadowRoot = this.attachShadow({ mode: 'open' });

    const wrapper: HTMLSpanElement = document.createElement('span');
    wrapper.setAttribute('class', 'wrapper');
    const icon: HTMLSpanElement = document.createElement('span');
    icon.setAttribute('class', 'icon');
    icon.setAttribute('tabindex', '0');
    const info: HTMLSpanElement = document.createElement('span');
    info.setAttribute('class', 'info');

    const text: string = this.getAttribute('text');
    info.textContent = text;

    let imgUrl: string;
    if (this.hasAttribute('img')) imgUrl = this.getAttribute('img');
    else imgUrl = 'img/default.png';
    const img: HTMLImageElement = document.createElement('img');
    img.src = imgUrl;
    icon.appendChild(img);

    const style: HTMLStyleElement = document.createElement('style');
    style.textContent = style.textContent = `
    .wrapper {
      position: relative;
    }
    .info {
      font-size: 0.8rem;
      width: 200px;
      display: inline-block;
      border: 1px solid black;
      padding: 10px;
      background: white;
      border-radius: 10px;
      opacity: 0;
      transition: 0.6s all;
      position: absolute;
      bottom: 20px;
      left: 10px;
      z-index: 3;
    }
    img {
      width: 1.2rem;
    }
    .icon:hover + .info, .icon:focus + .info {
      opacity: 1;
    }
  `;

    shadow.appendChild(style);
    shadow.appendChild(wrapper);
    wrapper.appendChild(icon);
    wrapper.appendChild(info);
  }
}

customElements.define('popup-info', PopUpInfo);