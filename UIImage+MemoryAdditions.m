//
//  UIImage+MemoryAdditions.m
//
//  Created by David Schiefer on 18.07.11.
//  Copyright 2011 David Schiefer. All rights reserved.
//

#import "UIImage+MemoryAdditions.h"

@implementation UIImage (DAMemoryAdditions)

+ (UIImage *)imageNamed:(NSString *)name
{
	NSArray*imageExtensions = [NSArray arrayWithObjects:@"jpg",@"png",@"jpeg",@"jp2",@"tiff",@"gif",nil];
	
	NSString*fittingExtension = @"";
	
	if ([[name pathExtension] isEqualToString:@""])
	{
		for (NSString*ext in imageExtensions)
		{
			NSString*tempName = [NSString stringWithFormat:@"%@.%@",name,ext];
			
			NSString*path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:tempName];
			
			if ([[NSFileManager defaultManager] fileExistsAtPath:path])
			{
				fittingExtension = ext;
			}
		}
		
		if ([fittingExtension isEqualToString:@""])
		{
			NSLog(@"ERROR: 'imageNamed:' returned null for image %@!",name);
			return NULL;
		}
		else
		{
			name = [NSString stringWithFormat:@"%@.%@",name,fittingExtension];
		}
	}

	NSString*path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
	
	NSData*imageData = [NSData dataWithContentsOfFile:path];
	
	return [UIImage imageWithData:imageData];
}

@end
