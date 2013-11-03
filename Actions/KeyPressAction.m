/**
 * Copyright (c) 2007-2013, Carsten Blüm <carsten@bluem.net>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 * - Neither the name of Carsten Blüm nor the names of his contributors may be
 *   used to endorse or promote products derived from this software without specific
 *   prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "KeyPressAction.h"

@implementation KeyPressAction

+(NSString *)commandListShortcut {
    return @"kp";
}

+(NSString *)commandDescription {
    return @"  kp:key  Will emulate PRESSING A KEY (key down + key up). For the moment,\n"
    "          only “return” or “esc” can be used as key.\n"
    "          Example: “kp:return” will hit the return key.";
}

-(void)performActionWithKeycode:(CGKeyCode)code {    
    CGEventRef e1 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)code, true);
    CGEventPost(kCGSessionEventTap, e1);

    CGEventRef e2 = CGEventCreateKeyboardEvent(NULL, (CGKeyCode)code, false);
    CGEventPost(kCGSessionEventTap, e2);
}

-(NSString *)actionDescriptionString:(NSString *)keyName {
    return [NSString stringWithFormat:@"Press + release %@ key", keyName];
}

+(NSDictionary *)getSupportedKeycodes {
    /*
     * NOTE: If you would like to add more keys, you can of course add key codes here, but
     * please be aware that the codes of most keys depend on the keyboard layout and thus
     * will not necessarily work as intended for other users. So feel free to add key codes
     * for your personal needs, but I will not merge pull requests that extend this
     * list of codes with keys that are not "safe" (such as the ones currently in the list).
     * Cf. https://github.com/BlueM/cliclick/pull/2
     */
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"36", @"return",
            @"53", @"esc",
            nil];
}

@end
