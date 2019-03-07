class Square extends HTMLElement {
    constructor() {
        super();
        this.shadow = this.attachShadow({ mode: 'open' });
        const div = document.createElement('div');
        const style = document.createElement('style');
        this.shadow.appendChild(style);
        this.shadow.appendChild(div);
    }
    static get observedAttributes() {
        return ['c', 'l'];
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
    attributeChangedCallback(attrName, oldVal, newVal) {
        console.log('属性値が変更されました');
        this.updateStyle();
    }
    updateStyle() {
        const childNodes = Array.from(this.shadow.childNodes);
        childNodes.forEach((childNode) => {
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
    const createButton = document.getElementById('create-button');
    const changeButton = document.getElementById('change-button');
    const removeButton = document.getElementById('remove-button');
    const container = document.querySelector('.container');
    stateChanged(createButton, changeButton, removeButton);
    createButton.addEventListener('click', (e) => {
        const customSquare = document.createElement('custom-square');
        container.appendChild(customSquare);
        stateChanged(createButton, changeButton, removeButton);
        setShape();
    });
    changeButton.addEventListener('click', (e) => {
        setShape();
        stateChanged(createButton, changeButton, removeButton);
    });
    removeButton.addEventListener('click', (e) => {
        const customSquare = document.querySelector('custom-square');
        customSquare.remove();
        stateChanged(createButton, changeButton, removeButton);
    });
});
function stateChanged(createButton, changeButton, removeButton) {
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
    const customSquare = document.querySelector('custom-square');
    customSquare.setAttribute('l', (Math.random() * (200 - 100) + 100).toString());
    const r = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
    const g = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
    const b = `0${Math.floor(Math.random() * 255).toString(16)}`.slice(-2);
    customSquare.setAttribute('c', `#${r}${g}${b}`);
}
