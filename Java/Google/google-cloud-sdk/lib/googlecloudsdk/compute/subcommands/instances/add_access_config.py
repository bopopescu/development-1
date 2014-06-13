# Copyright 2014 Google Inc. All Rights Reserved.
"""Command for adding access configs to virtual machine instances."""
from googlecloudapis.compute.v1 import compute_v1_messages as messages
from googlecloudsdk.compute.lib import base_classes
from googlecloudsdk.compute.lib import constants


class AddAccessConfigInstances(base_classes.BaseAsyncMutator):
  """Add access configs to Google Compute Engine virtual machine instances."""

  @staticmethod
  def Args(parser):
    access_config_name = parser.add_argument(
        '--access-config-name',
        default=constants.DEFAULT_ACCESS_CONFIG_NAME,
        help='Specifies the name of the new access configuration.')
    access_config_name.detailed_help = """\
        Specifies the name of the new access configuration. ``{0}''
        is used as the default if this flag is not provided.
        """.format(constants.DEFAULT_ACCESS_CONFIG_NAME)

    address = parser.add_argument(
        '--address',
        help=('Specifies the external IP address of the new access '
              'configuration.'))
    address.detailed_help = """\
        Specifies the external IP address of the new access
        configuration. If this is not specified, then the service will
        choose an available ephemeral IP address. If an explicit IP
        address is given, then that IP address must be reserved by the
        project and not be in use by another resource.
        """

    network_interface = parser.add_argument(
        '--network-interface',
        default='nic0',
        help=('Specifies the name of the network interface on which to add '
              'the new access configuration.'))
    network_interface.detailed_help = """\
        Specifies the name of the network interface on which to add the new
        access configuration. If this is not provided, then "nic0" is used
        as the default.
        """

    name = parser.add_argument(
        'name',
        help=('The name of, or a fully- or partially-qualified path to the '
              'instance to which to add the access configuration.'))
    name.detailed_help = """\
        The name of, or a fully- or partially-qualified path to the
        instance to which to add the access configuration. Using a
        path containing the zone will render the --zone flag
        optional. For example, providing
        ``us-central2-a/instances/my-instance'' is equivalent to
        providing ``my-instance'' with ``--zone us-central2-a''.
        """

    parser.add_argument(
        '--zone',
        help='The zone of the instance.')

  @property
  def service(self):
    return self.context['compute'].instances

  @property
  def method(self):
    return 'AddAccessConfig'

  @property
  def print_resource_type(self):
    return 'instances'

  def CreateRequests(self, args):
    """Returns a list of request necessary for adding an access config."""

    instance_context = self.context['path-handler'].Parse(
        'instances', args.name, zone=args.zone)

    request = messages.ComputeInstancesAddAccessConfigRequest(
        accessConfig=messages.AccessConfig(
            name=args.access_config_name,
            natIP=args.address,
            type=messages.AccessConfig.TypeValueValuesEnum.ONE_TO_ONE_NAT),
        instance=instance_context['instance'],
        networkInterface=args.network_interface,
        project=instance_context['project'],
        zone=instance_context['zone'])

    return [request]


AddAccessConfigInstances.detailed_help = {
    'brief': ('Create an access configuration for the network interface of a '
              'Google Compute Engine virtual machine'),
    'DESCRIPTION': """\
        *{command}* is used to create access configurations for network
        interfaces of Google Compute Engine virtual machines.
        """,
}

