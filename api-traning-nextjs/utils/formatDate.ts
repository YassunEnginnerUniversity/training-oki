export const formatDate = (timestamp: string) => {
  const date = new Date(timestamp);
  const formattedDate = `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日`;

  return formattedDate;
};
