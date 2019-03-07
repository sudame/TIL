class ExpandingList extends HTMLUListElement {
  constructor() {
    super();

    window.onload = () => {
      const uls: HTMLUListElement[] = Array.from(document.querySelectorAll(':root ul'));
      const lis: HTMLLIElement[] = Array.from(document.querySelectorAll(':root li'));

      uls.slice(1).forEach((ul: HTMLUListElement) => {
        ul.style.display = 'none';
      });

      lis.forEach((li: HTMLLIElement) => {
        const childText: ChildNode = li.childNodes[0];
        const newSpan: HTMLSpanElement = document.createElement('span');

        newSpan.textContent = childText.textContent;
        childText.parentElement.insertBefore(newSpan, childText);
        childText.parentElement.removeChild(childText);
      });

      const spans: HTMLSpanElement[] = Array.from(document.querySelectorAll(':root span'));

      spans.forEach((span: HTMLSpanElement) => {
        if (span.nextElementSibling) {
          span.style.cursor = 'pointer';
          span.parentElement.setAttribute('class', 'closed');
          span.onclick = this.showul;
        }
      });
    }
  }

  showul(e: MouseEvent) {
    const nextul: HTMLElement = <HTMLElement>(<HTMLElement>e.target).nextElementSibling;

    if (nextul.style.display === 'block') {
      nextul.style.display = 'none';
      nextul.parentElement.setAttribute('class', 'closed');
    } else {
      nextul.style.display = 'block';
      nextul.parentElement.setAttribute('class', 'open');
    }
  }
}

customElements.define('expanding-list', ExpandingList, { extends: 'ul' });