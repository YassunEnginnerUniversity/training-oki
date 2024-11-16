import Link from "next/link"
import { Button } from "../ui/button"
import { getUser } from "@/actions/user/getUser"

interface PageHeaderProps {
  username: string
}

const PageHeader = async () => {
  const user = await getUser();

  console.log(user);
  
  

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
            <Link href={"/user/" + user.username.id} className="text-base hover:opacity-70">{ user.username }</Link>
            </div>
            <div>
              <Button className="justify-self-end">ログアウト</Button>
            </div>
          </>
          ) : (
            <div>
              <Link href={"/login"} className="justify-self-end">ログイン</Link>
            </div>
          )}
        </div>
      </div>
    </header>
  )
}

export default PageHeader