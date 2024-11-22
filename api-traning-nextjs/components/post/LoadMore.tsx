"use client"

import Loading from "@/components/utils/Loading";
import { ReactNode, useCallback, useEffect, useRef, useState } from "react"

type LoadMoreAction = (
  page: number,
  type: string,
  userId: number
) => Promise<readonly [JSX.Element[], number | null, number | null] > ;

interface LoadMoreProps {
  children: ReactNode
  loadMoreAction: LoadMoreAction
  initialPage: number,
  type: string,
  userId: number
}

const LoadMore = ({children, loadMoreAction, initialPage, type, userId}: LoadMoreProps) => {
  const ref = useRef<HTMLButtonElement>(null);
  const [loadMoreNodes, setLoadMoreNodes] = useState<JSX.Element[]>([]);
  const [loading, setLoading] = useState(false);
  const [allDataLoaded, setAllDataLoaded] = useState(false);


  // 現在のページ
  const nexPage = useRef<number | undefined>(initialPage + 1)

  console.log(loadMoreNodes);
  

  const loadMore = useCallback(async(abortController?: AbortController) => {
    // ローティングさせる
    setLoading(true);
    setTimeout(async () => {
      if (nexPage.current === undefined) {
        setLoading(false);
        return;
      }

      loadMoreAction(nexPage.current, type, userId)
      .then(([node, currentPage, totalPage]) => {
        if(currentPage !== null && totalPage !== null && currentPage > totalPage) {
          setLoading(false);
          return;
        }

        // 全てのデータを取得したかどうかのチェック
        // if (node.length < 10) {
        //   setAllDataLoaded(true);
        // }
        // 新しいデータを追加する
        setLoadMoreNodes((prev) => [...prev, ...node]);

        if (currentPage === null) {
          nexPage.current = undefined;
          return;
        }

        // 次のページの値をいれるためプラス1している
        nexPage.current = currentPage + 1
      })
      .catch((e) => {
        console.log(e);
      })
      .finally(() => setLoading(false));
    }, 800);
  },[loadMoreAction])

  useEffect(() => {
    const abortController = new AbortController();

    const element = ref.current;

    const observer = new IntersectionObserver(([entry]) => {
      if (entry.isIntersecting && element?.disabled === false) {
        loadMore();
      }
    });

    if (element) {
      observer.observe(element);
    }

    return () => {
      abortController.abort();
      if (element) {
        observer.unobserve(element);
      }
    }
  }, [loadMore])

  return (
    <>
    <div className="space-y-4">
      {children}
      {loadMoreNodes}
    </div>
    {!allDataLoaded && (
      <button className='w-full flex justify-center items-center' ref={ref}>
        {loading && <Loading size={12} />}
      </button>
    )}
    </>
  )
}

export default LoadMore