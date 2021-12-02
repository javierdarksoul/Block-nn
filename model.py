import torch

class nnblock(torch.nn.Module):
    def __init__(self):
        super(nnblock,self).__init__()
        self.conv1=torch.nn.Conv2d(2,2,3)
        self.conv2=torch.nn.Conv2d(2,1,2)
        self.mpool=torch.nn.MaxPool2d(2)
    def forward(self):
        return 0