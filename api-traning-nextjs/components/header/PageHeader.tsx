import Link from "next/link"
import { Button } from "../ui/button"
import { getUserBySession } from "@/actions/user/getUserBySession"

interface PageHeaderProps {
  username: string
}

const PageHeader = async () => {
  const user = await getUserBySession();
  const username = user.username

  return (
    <header>
      <div className="flex items-center justify-between px-5 py-7">
        <div className="">
          <h1 className="text-xl">API-Traning-Nextjs</h1>
        </div> 
        <div className="flex items-center gap-6">
          {user? (
          <>
            <div>
            <Link href={"/user/" + username.id} className="text-base hover:opacity-70">{ username }</Link>
            </div>
            <div>
              <Button className="justify-self-end">ログアウト</Button>
            </div>
          </>
          ) : (
            <div>
              <Button variant="outline" className="justify-self-end">ログイン</Button>
            </div>
          )}
        </div>
      </div>
    </header>
  )
}

export default PageHeader