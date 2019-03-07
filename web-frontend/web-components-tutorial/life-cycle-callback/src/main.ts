class Square extends HTMLElement {
  private shadow: ShadowRoot = this.attachShadow({ mode: 'open' });

  static get observedAttributes() {
    return ['c', 'l'];
  }

  constructor() {
    super();

    const div: HTMLDivElement = document.createElement('div');
    const style: HTMLStyleElement = document.createElement('style');

    this.shadow.appendChild(style);
    this.shadow.appendChild(div);
  }

  connectedCallback() {
    console.log('ページに追加されました');
    this.updateStyle();
  }

  disconnectedCallback() {
    console.log('ページから削除されました');
  }

  adoptedCallback() {
    console.log('新規ページに移動しました');
  }

  attributeChangedCallback(attrName: string, oldVal: string, newVal: string) {
    console.log('属性値が変更されました');
    this.updateStyle();
  }

  private updateStyle() {
    const childNodes: ChildNode[] = Array.from(this.shadow.childNodes);
    childNodes.forEach((childNode: ChildNode) => {
      if (childNode.nodeName === 'STYLE') {
        childNode.textContent = `div{
          width: ${this.getAttribute('l')}px;
          height: ${this.getAttribute('l')}px;
          background-color: ${this.getAttribute('c')};
        }`;
      }
    });
  }
}

customElements.define('custom-square', Square);

document.addEventListener('DOMContentLoaded', () => {
  const createButton: HTMLButtonElement = <HTMLButtonElement>document.getElementById('create-button');
  const changeButton: HTMLButtonElement = <HTMLButtonElement>document.getElementById('change-button');
  const removeButton: HTMLButtonElement = <HTMLButtonElement>document.getElementById('remove-button');
  const container: HTMLDivElement = <HTMLDivElement>document.querySelector('.container');

  stateChanged(createButton, changeButton, removeButton);

  createButton.addEventListener('click', (e: MouseEvent) => {
    const customSquare: Square = <Square>document.createElement('custom-square');
    container.appendChild(customSquare);
    stateChanged(createButton, changeButton, removeButton);
    setShape();
  });
  changeButton.addEventListener('click', (e: MouseEvent) => {
    setShape();
    stateChanged(createButton, changeButton, removeButton);
  });
  removeButton.addEventListener('click', (e: MouseEvent) => {
    const customSquare: Square = <Square>document.querySelector('custom-square');
    customSquare.remove();
    stateChanged(createButton, changeButton, removeButton);
  });
});

function stateChanged(createButton: HTMLButtonElement, changeButton: HTMLButtonElement, removeButton: HTMLButtonElement) {
  if (document.querySelector('custom-square')) {
    createButton.disabled = true;
    changeButton.disabled = false;
    removeButton.disabled = false;
  }
  else {
    createButton.disabled = false;
    changeButton.disabled = true;
    removeButton.disabled = true;
  }
}

function setShape() {
  const customSquare: Square = <Square>document.querySelector('custom-square');
  customSquare.setAttribute('l', (Math.random() * (200 - 100) + 100).toString());
  const r: string = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
  const g: string = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
  const b: string = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
  customSquare.setAttribute('c', `#${r}${g}${b}`);
}