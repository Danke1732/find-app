if (document.URL.match( /articles[/]new/ ) || document.URL.match( /articles/ )) {
  // カテゴリー親要素選択時の子要素表示
  function categoryParentSelect() {
    const parentCategoryBox = document.getElementById('category-select-box');
    const secondCategoryArea = document.getElementById('second-Category');
    const thirdCategoryArea = document.getElementById('third-Category');
    if (parentCategoryBox.getAttribute('data-load') != null) {
      return null;
    }
    parentCategoryBox.setAttribute('data-load', 'true');
    parentCategoryBox.addEventListener('change', () => {
      let parentCategory = document.getElementById('category-select-box').value;
      if (parentCategory != '') {
        const XHR = new XMLHttpRequest();
        XHR.open('GET', `/articles/get_category_children/${parentCategory}`, true);
        XHR.responseType = 'json';
        XHR.send();
        XHR.onload = () => {
          if (XHR.status != 200) {
            alert(`Error ${XHR.status}: ${XHR.statusText}`);
            return null;
          }
          // 子要素カテゴリー及び孫要素カテゴリーがあれば削除
          if (thirdCategoryArea.firstChild) {
            thirdCategoryArea.removeChild(thirdCategoryArea.firstChild);
          }
          if (secondCategoryArea.firstChild) {
            secondCategoryArea.removeChild(secondCategoryArea.firstChild);
          }
          // json返却
          const categoryChildren = XHR.response.children;
          // 子要素カテゴリーselect要素作成
          const childrenCategoryBox = document.createElement('select');
          childrenCategoryBox.setAttribute('class', 'input-default category-box2');
          childrenCategoryBox.setAttribute('id', 'category-select-box2');
          childrenCategoryBox.setAttribute('name', 'article[category_id]');
          // 子要素カテゴリーoption要素作成('---'の作成)
          const optionFirst = document.createElement('option');
          optionFirst.innerHTML = '---';
          childrenCategoryBox.appendChild(optionFirst);
          // 子要素カテゴリーoption要素作成(各親要素ごとの子要素)
          categoryChildren.forEach((child) => {
            let option = document.createElement('option');
            option.setAttribute('value', `${child.id}`);
            option.innerHTML = `${child.name}`;
            childrenCategoryBox.appendChild(option);
          });
          // ビュー画面へ描画
          secondCategoryArea.appendChild(childrenCategoryBox);
        }
      } else {
        // 子要素カテゴリー及び孫要素カテゴリーがあれば削除
        if (thirdCategoryArea.firstChild) {
          thirdCategoryArea.removeChild(thirdCategoryArea.firstChild);
        }
        if (secondCategoryArea.firstChild) {
          secondCategoryArea.removeChild(secondCategoryArea.firstChild);
        }
      }
    });
  }
  
  // カテゴリー子要素選択時の孫要素表示
  function categoryChildSelect() {
    const childrenCategoryBox = document.getElementById('category-select-box2');
    const thirdCategoryArea = document.getElementById('third-Category');
    if (childrenCategoryBox.getAttribute('data-load') != null) {
      return null;
    }
    childrenCategoryBox.setAttribute('data-load', 'true');
    childrenCategoryBox.addEventListener('change', () => {
      let childCategory = document.getElementById('category-select-box2').value;
      if (childCategory != '---') {
        const XHR = new XMLHttpRequest();
        XHR.open('GET', `/articles/get_category_grandchildren/${childCategory}`, true);
        XHR.responseType = 'json';
        XHR.send();
        XHR.onload = () => {
          if (XHR.status != 200) {
            alert(`Error ${XHR.status}: ${XHR.statusText}`);
            return null;
          }
          // 孫要素カテゴリーがあれば削除
          if (thirdCategoryArea.firstChild) {
            thirdCategoryArea.removeChild(thirdCategoryArea.firstChild);
          }
          // jsonデータ返却
          const categoryGrandChildren = XHR.response.grandChildren;
          // 孫要素カテゴリーselect要素作成
          const grandChildrenCategoryBox = document.createElement('select');
          grandChildrenCategoryBox.setAttribute('class', 'input-default category-box3');
          grandChildrenCategoryBox.setAttribute('id', 'category-select-box3');
          grandChildrenCategoryBox.setAttribute('name', 'article[category_id]');
          // 孫要素カテゴリーoption要素作成('---'の作成)
          const optionFirst = document.createElement('option');
          optionFirst.innerHTML = '---';
          grandChildrenCategoryBox.appendChild(optionFirst);
          // 孫要素カテゴリーoption要素作成(各子要素ごとの孫要素)
          categoryGrandChildren.forEach((grandChild) => {
            let option = document.createElement('option');
            option.setAttribute('value', `${grandChild.id}`);
            option.innerHTML = `${grandChild.name}`;
            grandChildrenCategoryBox.appendChild(option);
          });
          // ビュー画面へ描画
          thirdCategoryArea.appendChild(grandChildrenCategoryBox);
        }
      } else {
        // 孫要素カテゴリーがあれば削除
        if (thirdCategoryArea.firstChild) {
          thirdCategoryArea.removeChild(thirdCategoryArea.firstChild);
        }
      }
     });
  }
  setInterval(categoryParentSelect, 1000);
  setInterval(categoryChildSelect, 1000);
}