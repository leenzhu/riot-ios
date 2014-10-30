/*
 Copyright 2014 OpenMarket Ltd
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "AppSettings.h"
#import "MatrixHandler.h"

static AppSettings *sharedSettings = nil;

@implementation AppSettings

+ (AppSettings *)sharedSettings {
    @synchronized(self) {
        if(sharedSettings == nil)
        {
            sharedSettings = [[super allocWithZone:NULL] init];
        }
    }
    return sharedSettings;
}

#pragma  mark - 

-(AppSettings *)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)dealloc {
}

- (void)reset {
    self.enableNotifications = NO;
    self.displayAllEvents = NO;
}

#pragma mark -

- (BOOL)enableNotifications {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"enableNotifications"];
}

- (void)setEnableNotifications:(BOOL)notifications {
    [[MatrixHandler sharedHandler] enableEventsNotifications:notifications];
    [[NSUserDefaults standardUserDefaults] setBool:notifications forKey:@"enableNotifications"];
}

- (BOOL)displayAllEvents {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"displayAllEvents"];
}

- (void)setDisplayAllEvents:(BOOL)displayAllEvents {
    [[NSUserDefaults standardUserDefaults] setBool:displayAllEvents forKey:@"displayAllEvents"];
    // Flush and restore Matrix data
    [[MatrixHandler sharedHandler] forceInitialSync];
}
@end