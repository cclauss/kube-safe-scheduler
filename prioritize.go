package main

import (
	v1 "k8s.io/api/core/v1"
	schedulerapi "k8s.io/kubernetes/pkg/scheduler/api"
)

// Prioritize :
type Prioritize struct {
	Name string
	Func func(pod v1.Pod, nodes []v1.Node) (*schedulerapi.HostPriorityList, error)
}

// Handler :
func (p Prioritize) Handler(args schedulerapi.ExtenderArgs) (*schedulerapi.HostPriorityList, error) {
	return p.Func(*args.Pod, args.Nodes.Items)
}
