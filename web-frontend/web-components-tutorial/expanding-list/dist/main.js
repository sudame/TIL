class ExpandingList extends HTMLUListElement {
    constructor() {
        super();
        window.onload = () => {
            const uls = Array.from(document.querySelectorAll(':root ul'));
            const lis = Array.from(document.querySelectorAll(':root li'));
            uls.slice(1).forEach((ul) => {
                ul.style.display = 'none';
            });
            lis.forEach((li) => {
                const childText = li.childNodes[0];
                const newSpan = document.createElement('span');
                newSpan.textContent = childText.textContent;
                childText.parentElement.insertBefore(newSpan, childText);
                childText.parentElement.removeChild(childText);
            });
            const spans = Array.from(document.querySelectorAll(':root span'));
            spans.forEach((span) => {
                if (span.nextElementSibling) {
                    span.style.cursor = 'pointer';
                    span.parentElement.setAttribute('class', 'closed');
                    span.onclick = this.showul;
                }
            });
        };
    }
    showul(e) {
        const nextul = e.target.nextElementSibling;
        if (nextul.style.display === 'block') {
            nextul.style.display = 'none';
            nextul.parentElement.setAttribute('class', 'closed');
        }
        else {
            nextul.style.display = 'block';
            nextul.parentElement.setAttribute('class', 'open');
        }
    }
}
customElements.define('expanding-list', ExpandingList, { extends: 'ul' });
