'use client';

import PostList from '@/components/post/PostList';
import Loading from '@/components/utils/Loading';
import { Post } from '@/types/post/types';
import { getLoadMorePosts } from '@/utils/getLoadMorePosts';
import { useCallback, useEffect, useRef, useState } from 'react';

interface LoadMoreProps {
  tab: string;
  userId: number;
}

const LoadMorePostList = ({ tab, userId }: LoadMoreProps) => {
  const ref = useRef<HTMLDivElement>(null);
  const [loading, setLoading] = useState(false);
  const [posts, setPosts] = useState<Post[]>([]);
  const initialPage = 1;

  // 次のページ
  const nexPage = useRef<number | undefined>(initialPage + 1);

  // ローディング中に投稿を取得する
  const loadMore = useCallback(async () => {
    setLoading(true);

    setTimeout(async () => {
      // 次のページがない場合
      if (nexPage.current === undefined) {
        setLoading(false);
        return;
      }

      try {
        // 投稿を取得する
        const response = await getLoadMorePosts(tab, nexPage.current, userId);
        const currentPage = response.pagenation.current_page;
        const totalPage = response.pagenation.total_page;

        // すべての投稿を取得している場合、投稿の取得をしない
        if (
          currentPage !== null &&
          totalPage !== null &&
          currentPage > totalPage
        ) {
          setLoading(false);
          nexPage.current = undefined;
          return;
        }

        // 新しいデータを追加する
        setPosts((prev) => [...prev, ...response.posts]);

        // 次のページがある場合、次のページの値でrefを更新する
        nexPage.current = currentPage + 1;
      } catch (error) {
        console.error(error);
      } finally {
        setLoading(false);
      }
    }, 800);
  }, [tab, userId]);

  useEffect(() => {
    // スクロールしたときのターゲット
    const element = ref.current;

    // ターゲットがスクロールでビューポートに交差したらloadMoreを実行
    const observer = new IntersectionObserver(([entry]) => {
      if (entry.isIntersecting) {
        loadMore();
      }
    });

    // 要素が存在する場合は監視を続ける
    if (element) {
      observer.observe(element);
    }

    return () => {
      if (element) {
        observer.unobserve(element);
      }
    };
  }, [loadMore]);

  return (
    <div className="mt-4">
      <PostList posts={posts} />
      <div className="w-full flex justify-center items-center" ref={ref}>
        {loading && <Loading size={12} />}
      </div>
    </div>
  );
};

export default LoadMorePostList;
