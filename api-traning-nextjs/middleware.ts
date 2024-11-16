import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export async function middleware(request: NextRequest) {
  const sessionCookie = request.cookies.get('_api_and_rspec_training_session'); //Railsで指定したcookieのkey
  
  // cookieにセッション情報がない場合 そのページにアクセス
  if(!sessionCookie) {
    return NextResponse.next();
  }

  // cookieにセッション情報がある場合 サーバに保存されているセッション情報と比較
  const endpoint = process.env.NEXT_PUBLIC_API_ENDPOINT + "/api/check_session"
  const response = await fetch(endpoint, {
    headers: {
      Cookie: `${request.cookies}`,
    },
    credentials: 'include',
  })

  const responseData = await response.json();

  if(responseData.login_in) {
    // セッション情報が正しい場合 ルートパスへリダイレクト
    const redirectUrl = new URL('/', request.url);
    return NextResponse.redirect(redirectUrl);
  } else {
    // セッション情報が正しくない場合 そのページにアクセス
    return NextResponse.next();
  }
}

// middleware.tsを適用するパス
export const config = {
  matcher: '/login',
};