//
//  CSMacros.h
//  Nest
//
//  Created by Denis Kapusta on 12/22/15.
//  Copyright © 2015 Appko. All rights reserved.
//

#ifndef CSMacros_h
#define CSMacros_h

#define CSWeakObject(o) __typeof__(o) __weak
#define CSWeakSelf FCWeakObject(self)
#define CSStrongObject(o) __typeof__(o) __strong

#define CSMagicWeakObject(o, weakO) CSWeakObject(o) weakO = o;
#define CSMagicStrongObject(o, strongO) CSStrongObject(o) strongO = o;

#define CSBlockWeakSelf CSMagicWeakObject(self, weakSelf)
#define CSBlockStrongSelf CSMagicStrongObject(weakSelf, strongSelf)

#define CSBlockSafeRun(block, ...) block ? block(__VA_ARGS__) : nil


#ifdef DEBUG
#define CSLog(frmt, ...) NSLog(frmt, ## __VA_ARGS__ )
#else
#define CSLog(...) do {;} while(0)
#endif  //#ifdef DEBUG

#endif /* CSMacros_h */
