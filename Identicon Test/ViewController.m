//
//  ViewController.m
//  Identicon Test
//
//  Created by Cameron Currie on 10/18/17.
//  Copyright © 2017 Cameron Currie. All rights reserved.
//

#import "ViewController.h"
#import "identicon-c.h"
#import "lodepng.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *identiconStringValue;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (UIImage *)makeIdenticon:(NSString *)identiconString {
    const char *identiconStringC = [identiconString cStringUsingEncoding:(NSUTF8StringEncoding)];
    
    unsigned char* img = NULL;
    
    identicon_options_t* opts = new_default_identicon_options();
    
    int copyLength = strlen(identiconStringC) % IDENTICON_MAX_STRING_LENGTH;
    strncpy(opts->str, identiconStringC, copyLength);
    opts->str[copyLength] = '\0';
    
    opts->hash_type = IDENTICON_HASH_SHA512;
    opts->transparent = false;
    opts->stroke = false;
    opts->size = 256;
    
    img = new_identicon(opts);
    unsigned char *encodedImg = NULL;
    size_t encodedImgSize;

    lodepng_encode32(&encodedImg, &encodedImgSize, img, opts->size, opts->size);
    
    UIImage *image = [[UIImage alloc] initWithData:[[NSData alloc] initWithBytes:encodedImg length:encodedImgSize]];
    
    free(img);
    free(opts);
    free(encodedImg);
    
    return image;
}

- (IBAction)generateClicked:(id)sender {
    UIImage *image = [self makeIdenticon:[_identiconStringValue text]];
    [_imageView setImage:image];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
