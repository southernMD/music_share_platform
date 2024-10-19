(async () => {
  // 动态导入 a.js 和 b.js
  await import('./ScrollListener.js');
  await import('./UlSelect.js');
  await import('./IndexPictureChange.js');
  // 执行其他逻辑
  console.log('Main script executed');
  
})();